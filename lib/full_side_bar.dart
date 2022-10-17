import 'dart:math';

import 'package:flutter/material.dart';

///
/// Complete side menu:
/// - Current session information => Logged user.
///
class FullSideBar extends StatelessWidget {
  static const int _userCount = 10;
  static final int _randomUserId = Random().nextInt(_userCount + 1);

  const FullSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Jane Smith'),
            accountEmail: const Text('j.smith@work.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://randomuser.me/api/portraits/women/$_randomUserId.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/abstract-business-professional-background-banner-design-multipurpose_1340-16858.jpg?w=1380&t=st=1665958580~exp=1665959180~hmac=0a0c4ec52b4e3f01ddb309a8bde452d1c71affd4160ef4605dfa9646417ef43a')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Users'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Capture'),
            onTap: () async {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: const Text('Please Confirm'),
                      content:
                          const Text('Are you sure you would like to exit?'),
                      actions: [
                        // The "Yes" button
                        TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                              // Close the drawer
                              Navigator.of(context).pop();
                              // Go back to the login page
                              Navigator.of(context).pop();
                              //
                            },
                            child: const Text('Yes')),
                        TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
