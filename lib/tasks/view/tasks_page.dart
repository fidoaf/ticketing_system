import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/tasks/tasks.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key, int? userId}) : _userId = userId ?? -1;

  final int _userId;

  static Route<void> route([int? userId]) {
    return MaterialPageRoute<void>(builder: (_) => TasksPage(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocProvider(
        create: (_) {
          TaskBloc bloc =
              TaskBloc(dataRepository: context.read<PlaceholderDataAPI>());
          _userId == -1
              ? bloc.add(TaskFetched())
              : bloc.add(TaskByUserFetched(_userId));
          return bloc;
        },
        child: TaskList(
          userId: _userId,
        ),
      ),
    );
  }
}
