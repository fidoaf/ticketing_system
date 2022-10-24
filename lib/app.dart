import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';

import 'package:ticketing_system/dashboard_page.dart';
import 'package:ticketing_system/onboarding_page.dart';
import 'package:ticketing_system/section/section_bloc.dart';
import 'package:ticketing_system/section/section_repository.dart';

import 'package:ticketing_system/posts/posts.dart';
import 'package:ticketing_system/tasks/tasks.dart';
import 'package:ticketing_system/users/users.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required SectionRepository sectionRepository,
      required PlaceholderDataAPI dataRepository})
      : _sectionRepository = sectionRepository,
        _dataRepository = dataRepository;

  final SectionRepository _sectionRepository;
  final PlaceholderDataAPI _dataRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _dataRepository,
      child: BlocProvider(
        create: (_) => SectionBloc(sectionRepository: _sectionRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: const OnBoardingPage(),
      builder: (context, child) {
        return BlocListener<SectionBloc, SectionState>(
          listener: (context, state) {
            switch (state.status) {
              case AppSectionStatus.home:
                _navigator.pushAndRemoveUntil<void>(
                  DashboardPage.route(),
                  (route) => false,
                );
                break;
              case AppSectionStatus.users:
                _navigator.pushAndRemoveUntil<void>(
                  UsersPage.route(),
                  (route) => false,
                );
                break;
              case AppSectionStatus.posts:
                _navigator.pushAndRemoveUntil<void>(
                  PostsPage.route(),
                  (route) => false,
                );
                break;
              case AppSectionStatus.tasks:
                _navigator.pushAndRemoveUntil<void>(
                  TasksPage.route(),
                  (route) => false,
                );
                break;
              case AppSectionStatus.comments:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
