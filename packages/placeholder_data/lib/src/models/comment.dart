import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
    required this.postId,
  });

  final int id;
  final String name;
  final String email;
  final String body;
  final int postId;

  @override
  List<Object> get props => [id, name, body];
}
