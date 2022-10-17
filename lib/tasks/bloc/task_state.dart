part of 'task_bloc.dart';

enum TaskStatus { initial, success, failure }

class TaskState extends Equatable {
  const TaskState(
      {this.status = TaskStatus.initial,
      this.tasks = const <Task>[],
      this.hasReachedMax = false});

  final TaskStatus status;
  final List<Task> tasks;
  final bool hasReachedMax;

  TaskState copyWith({
    TaskStatus? status,
    List<Task>? tasks,
    bool? hasReachedMax,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''TaskState { status: $status, hasReachedMax: $hasReachedMax, tasks: ${tasks.length} }''';
  }

  @override
  List<Object?> get props => [status, tasks, hasReachedMax];
}
