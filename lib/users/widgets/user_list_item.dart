import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/posts/posts.dart';
import 'package:ticketing_system/tasks/tasks.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://randomuser.me/api/portraits/women/${user.id}.jpg'),
      ),
      isThreeLine: true,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 150,
        child: Row(
          children: [
            IconButton(
              tooltip: 'View posts',
              onPressed: () {
                Navigator.of(context).push(PostsPage.route(user.id));
              },
              icon: const FaIcon(FontAwesomeIcons.comments),
            ),
            IconButton(
              tooltip: 'View tasks',
              onPressed: () {
                Navigator.of(context).push(TasksPage.route(user.id));
              },
              icon: const FaIcon(FontAwesomeIcons.list),
            ),
          ],
        ),
      ),
    );
  }
}
