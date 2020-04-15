import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks/service_locator.dart';
import 'package:tasks/utils/id_generator.dart';
import 'package:tasks/views/app_drawer.dart';
import 'package:tasks/views/task_edit_dialog.dart';
import 'package:tasks/views/task_list_view.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    super.initState();
    _initDummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: Theme.of(context).textTheme,
        backgroundColor: Colors.white,
        title: Text(
          'Tasks',
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'delete all',
            icon: Icon(Icons.delete_sweep),
            onPressed: _removeAllCompleteTasks,
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: _showTaskAddDialog,
      ),
      body: TaskListView(),
    );
  }

  void _removeAllCompleteTasks() {
    get<TaskRepository>(context).removeAllComplete();
  }

  void _showTaskAddDialog() {
    showDialog(context: context, builder: (context) => TaskEditDialog());
  }

  void _initDummyData() {
    final task = Task((builder) {
      builder
        ..id = generateId()
        ..title = 'Change the FAB icon'
        ..isComplete = false;
    });
    get<TaskRepository>(context).add(task);
  }
}
