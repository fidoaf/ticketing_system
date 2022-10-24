import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';

import 'package:ticketing_system/common/widgets/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key, required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository;

  final PlaceholderDataAPI _dataRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _dataRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
    );
  }
}
