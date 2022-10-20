import 'package:flutter/material.dart';
import 'package:ticketing_system/tasks/tasks.dart';

class TasksListItem extends StatelessWidget {
  const TasksListItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {},
      child: Card(
          child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/women/${task.userId}.jpg'),
        ),
        title: SelectableText(task.title),
        isThreeLine: true,
        subtitle: ButtonBar(
          children: [
            IconButton(
                tooltip: task.completed ? 'Tak completed' : 'Assign task',
                onPressed: () {},
                icon: task.completed
                    ? const Icon(Icons.check)
                    : const Icon(Icons.assignment_ind))
          ],
        ),
        dense: true,
      )),
    );
  }
}
