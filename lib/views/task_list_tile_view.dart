import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/service_locator.dart';
import 'package:tasks/view_models/task_edit_view_model.dart';

import '../models/task.dart';
import 'task_edit_dialog.dart';

class TaskListTileView extends StatefulWidget {
  const TaskListTileView({
    Key key,
    this.task,
  }) : super(key: key);

  final Task task;

  @override
  _TaskListTileViewState createState() => _TaskListTileViewState();
}

class _TaskListTileViewState extends State<TaskListTileView> {
  TaskEditViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TaskEditViewModel(get(context), task: widget.task);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _viewModel.setTask(widget.task);
    return StreamBuilder<Task>(
      initialData: widget.task,
      stream: _viewModel.task,
      builder: (context, snapshot) {
        final task = snapshot.data;
        return ListTile(
          leading: Checkbox(
            value: task.isComplete,
            onChanged: (isComplete) {
              _viewModel.setIsComplete(isComplete);
              _viewModel.save();
            },
          ),
          onTap: () {
            _showTaskAddDialog(task);
          },
          title: Text(task.title),
        );
      },
    );
  }

  void _showTaskAddDialog(Task task) {
    showDialog(
        context: context, builder: (context) => TaskEditDialog(task: task));
  }
}
