import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/repositories/task_repository.dart';
import 'package:tasks/service_locator.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Spacer(),
          ListTile(
            title: Text('Create dummy Tasks'),
            onTap: () {
              _createDummyTasks(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Remove all Tasks'),
            onTap: () {
              _removeAllTasks(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  _createDummyTasks(BuildContext context) {
    get<TaskRepository>(context).addAll(List.generate(10, (i) {
      return Task(
        (b) => b
          ..id = 'T$i'
          ..title = 'Task $i'
          ..isComplete = false,
      );
    }));
  }

  _removeAllTasks(BuildContext context) {
    get<TaskRepository>(context).removeAll();
  }
}
