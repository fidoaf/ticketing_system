import 'package:flutter/material.dart';
import 'package:ticketing_system/dashboard/widgets/dashboard_item.dart';
import 'package:ticketing_system/common/widgets/full_side_bar.dart';
import 'package:ticketing_system/posts/posts.dart';
import 'package:ticketing_system/tasks/tasks.dart';
import 'package:ticketing_system/users/users.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const FullSideBar(),
        body: const DashboardList());
  }
}

class DashboardList extends StatefulWidget {
  const DashboardList({super.key});

  @override
  State<DashboardList> createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  int? _focusedIndex;

  Widget _getSectionWidget(int index,
      {required String label,
      required Function handler,
      required IconData icon}) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _focusedIndex = index),
        onExit: (_) => setState(() => _focusedIndex = null),
        child: DashboardItem(
          label: label,
          icon: icon,
          handler: handler,
          mode: _focusedIndex == null
              ? 'restored'
              : (_focusedIndex == index ? 'maximized' : 'minimized'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getSectionWidget(0,
              label: 'Users',
              icon: Icons.people,
              handler: () => Navigator.of(context).push(UsersPage.route())),
          _getSectionWidget(1,
              label: 'Forum',
              icon: Icons.chat,
              handler: () => Navigator.of(context).push(PostsPage.route())),
          _getSectionWidget(2,
              label: 'Tasks',
              icon: Icons.task,
              handler: () => Navigator.of(context).push(TasksPage.route())),
        ],
      ),
    );
  }
}
