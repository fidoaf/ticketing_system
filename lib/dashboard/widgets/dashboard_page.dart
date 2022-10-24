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

  // double _getSectionHeight(BuildContext context, SectionState currentState,
  //     AppSectionStatus section) {
  //   double totalHeight = MediaQuery.of(context).size.height;
  //   double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
  //   if (currentState.focusedSection == AppSectionStatus.home) {
  //     // All sections equally sized
  //     return (totalHeight - (appBarHeight)) / 3;
  //   } else {
  //     return (totalHeight - (appBarHeight)) / 4;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const FullSideBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    //context.read<SectionBloc>().add(const SectionFocusChanged());
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: 300,
                    color: Colors.grey.shade50,
                    child: DashboardItem(
                      label: 'Users',
                      icon: Icons.people,
                      handler: () {
                        Navigator.of(context).push(UsersPage.route());
                      },
                    ),
                  )),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 300,
                color: Colors.grey.shade200,
                child: DashboardItem(
                  label: 'Forum',
                  icon: Icons.chat,
                  handler: () {
                    Navigator.of(context).push(PostsPage.route());
                  },
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 300,
                color: Colors.grey.shade50,
                child: DashboardItem(
                  label: 'Tasks',
                  icon: Icons.task,
                  handler: () {
                    Navigator.of(context).push(TasksPage.route());
                  },
                ),
              ),
            ],
          ),
        ));
  }
}


// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   static Route<void> route() {
//     return MaterialPageRoute<void>(builder: (_) => const DashboardPage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SectionBloc, SectionState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return Scaffold(
//             appBar: AppBar(),
//             drawer: const FullSideBar(),
//             body: Column(
//               // TODO: change the flex value of each item depending on the focused element
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey.shade50,
//                     child: DashboardItem(
//                       label: 'Users',
//                       icon: Icons.people,
//                       handler: () {
//                         Navigator.of(context).push(UsersPage.route());
//                       },
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey.shade200,
//                     child: DashboardItem(
//                       label: 'Forum',
//                       icon: Icons.chat,
//                       handler: () {
//                         Navigator.of(context).push(PostsPage.route());
//                       },
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey.shade50,
//                     child: DashboardItem(
//                       label: 'Tasks',
//                       icon: Icons.task,
//                       handler: () {
//                         Navigator.of(context).push(TasksPage.route());
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ));
//       },
//     );
//   }
// }
