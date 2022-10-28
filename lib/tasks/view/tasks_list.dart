import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/tasks/tasks.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key, int? userId}) : _userId = userId ?? -1;

  final int _userId;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        switch (state.status) {
          case TaskStatus.failure:
            return const Center(child: Text('failed to fetch tasks'));
          case TaskStatus.success:
            if (state.tasks.isEmpty) {
              return const Center(child: Text('no tasks'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.tasks.length
                    ? const BottomLoader()
                    : TasksListItem(task: state.tasks[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.tasks.length
                  : state.tasks.length + 1,
              controller: _scrollController,
            );
          case TaskStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TaskBloc>().add(widget._userId == -1
          ? TaskFetched()
          : TaskByUserFetched(widget._userId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
