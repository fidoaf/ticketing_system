import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/common/bloc/event_transformer.dart';

part 'task_event.dart';
part 'task_state.dart';

const throttleDuration = Duration(milliseconds: 100);

// TODO: Refactor methods

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository,
        super(const TaskState()) {
    on<TaskFetched>(
      _onTaskFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<TaskByUserFetched>(
      _onTaskByUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final PlaceholderDataAPI _dataRepository;

  Future<void> _onTaskFetched(
    TaskFetched event,
    Emitter<TaskState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TaskStatus.initial) {
        final tasks = await _dataRepository.fetchTasks();
        return emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: tasks,
            hasReachedMax: false,
          ),
        );
      }
      final tasks = await _dataRepository.fetchTasks(state.tasks.length);
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

  Future<void> _onTaskByUserFetched(
    TaskByUserFetched event,
    Emitter<TaskState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TaskStatus.initial) {
        final tasks = await _dataRepository.fetchUserTasks(event.userId);
        return emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: tasks,
            hasReachedMax: false,
          ),
        );
      }
      final tasks = await _dataRepository.fetchUserTasks(
          event.userId, state.tasks.length);
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
}
