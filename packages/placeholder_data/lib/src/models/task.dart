import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
  });

  final int id;
  final String title;
  final bool completed;
  final int userId;

  @override
  List<Object> get props => [id, title, completed, userId];
}
