import 'package:flutter/material.dart';
import 'package:ticketing_system/comments/comments.dart';
import 'package:ticketing_system/posts/posts.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () {},
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(CommentsPage.route(post.id));
          },
          child: Card(
              child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/${post.userId}.jpg'),
            ),
            title: Text(post.title),
            isThreeLine: true,
            subtitle: Text(post.body),
            dense: true,
          )),
        ));
  }
}
