import 'package:flutter/material.dart';
import 'package:ticketing_system/comments/comments.dart';
import 'package:placeholder_data/placeholder_data.dart';

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
            title: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan>[TextSpan(text: post.title)])),
            isThreeLine: true,
            subtitle: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[TextSpan(text: post.body)])),
            dense: true,
          )),
        ));
  }
}
