import 'package:flutter/material.dart';
import 'package:ticketing_system/users/users.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {},
      child: Card(
          child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/women/${user.id}.jpg'),
        ),
        title: Text(user.name),
        isThreeLine: true,
        subtitle: Text(user.email),
        dense: true,
      )),
    );
  }
}
