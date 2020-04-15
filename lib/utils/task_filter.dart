import 'package:built_collection/built_collection.dart';
import 'package:tasks/models/task.dart';

extension TaskListExteions on BuiltList<Task> {
  BuiltList<Task> filterByTitle(String title) {
    if (title != null) {
      return this.rebuild((b) {
        b.where((task) => task.title.contains(title));
      });
    } else {
      return this;
    }
  }
}
