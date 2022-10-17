import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/section/section_bloc.dart';

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
          body: Text(''),
        );
      },
    );
  }
}
