import 'package:flutter/material.dart';
import 'package:ticketing_system/posts/posts.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {},
      child: Card(
          child: ListTile(
        leading: ClipOval(
            child: Image.network(
                'https://randomuser.me/api/portraits/women/${post.userId}.jpg')),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      )),
    );
  }
}
