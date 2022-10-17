import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketing_system/tasks/models/models.dart';
import 'package:ticketing_system/tasks/tasks.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'task_event.dart';
part 'task_state.dart';

const _taskLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required this.httpClient}) : super(const TaskState()) {
    on<TaskFetched>(
      _onTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onTaskFetched(
    TaskFetched event,
    Emitter<TaskState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TaskStatus.initial) {
        final tasks = await _fetchTasks();
        return emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: tasks,
            hasReachedMax: false,
          ),
        );
      }
      final tasks = await _fetchTasks(state.tasks.length);
      tasks.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: TaskStatus.success,
                tasks: List.of(state.tasks)..addAll(tasks),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: TaskStatus.failure));
    }
  }

  Future<List<Task>> _fetchTasks([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/todos',
        <String, String>{'_start': '$startIndex', '_limit': '$_taskLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Task(
          id: map['id'] as int,
          title: map['title'] as String,
          completed: map['completed'] as bool,
          userId: map['userId'] as int,
        );
      }).toList()
        ..shuffle();
    }
    throw Exception('error fetching tasks');
  }
}
