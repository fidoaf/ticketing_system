part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskFetched extends TaskEvent {}

class TaskByUserFetched extends TaskEvent {
  const TaskByUserFetched(this.userId);

  final int userId;

  @override
  List<Object> get props => [userId];
}
