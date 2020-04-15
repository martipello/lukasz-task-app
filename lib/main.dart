import 'package:flutter/material.dart';
import 'package:tasks/repositories/task_repository.dart';
import 'package:tasks/service_locator.dart';

import 'views/task_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServiceLocator(
      dependencies: () => {
        TaskRepository(),
      },
      child: MaterialApp(
        title: 'Tasks',
        home: TaskListPage(),
      ),
    );
  }
}
