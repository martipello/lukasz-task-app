import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/service_locator.dart';
import 'package:tasks/view_models/task_list_view_model.dart';

import 'task_list_tile_view.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  TaskListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TaskListViewModel(get(context))..init();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<Task>>(
      initialData: _viewModel.tasks.value,
      stream: _viewModel.tasks,
      builder: (context, snapshot) {
        final tasks = snapshot.data;
        if (tasks != null) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = snapshot.data[index];
              return TaskListTileView(key: ObjectKey(task), task: task);
            },
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
