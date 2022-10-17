import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/tasks/tasks.dart';
import 'package:http/http.dart' as http;

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TasksPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocProvider(
        create: (_) => TaskBloc(httpClient: http.Client())..add(TaskFetched()),
        child: const TaskList(),
      ),
    );
  }
}
