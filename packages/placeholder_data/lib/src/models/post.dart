import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int id;
  final String title;
  final String body;
  final int userId;

  @override
  List<Object> get props => [id, title, body];
}
