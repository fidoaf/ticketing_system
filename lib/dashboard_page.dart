import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/dashboard_item.dart';
import 'package:ticketing_system/full_side_bar.dart';
import 'package:ticketing_system/posts/posts.dart';
import 'package:ticketing_system/section/section_bloc.dart';
import 'package:ticketing_system/users/users.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionBloc, SectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: const FullSideBar(),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DashboardItem(
                label: 'Users',
                icon: Icons.people,
                handler: () {
                  Navigator.of(context).push(UsersPage.route());
                },
              ),
              DashboardItem(
                  label: 'Forum',
                  icon: Icons.chat,
                  handler: () {
                    Navigator.of(context).push(PostsPage.route());
                  }),
              DashboardItem(label: 'Tasks', icon: Icons.task, handler: () {}),
            ],
          )),
        );
      },
    );
  }
}
