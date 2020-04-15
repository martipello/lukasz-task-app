import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/service_locator.dart';
import 'package:tasks/view_models/task_edit_view_model.dart';

class TaskEditDialog extends StatefulWidget {
  const TaskEditDialog({Key key, this.task}) : super(key: key);

  final Task task;

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  TaskEditViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                initialValue: _viewModel.task.value.title,
                validator: validate,
                onChanged: _viewModel.setTitle,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Task title',
                ),
              ),
            ),
            SizedBox(height: 14),
            FlatButton(
              color: Colors.blueGrey,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _viewModel.save();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String validate(String text) {
    if (text.isNotEmpty) {
      return null;
    } else {
      return 'Please enter text to save';
    }
  }
}
