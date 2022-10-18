import 'package:flutter/material.dart';
import 'package:ticketing_system/comments/comments.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: null,
      title: Text(comment.name),
      isThreeLine: true,
      subtitle: Text(comment.body),
      dense: true,
    ));
  }
}
