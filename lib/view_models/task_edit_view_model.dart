import 'package:rxdart/rxdart.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/utils/id_generator.dart';

import '../repository.dart';

class TaskEditViewModel {
  TaskEditViewModel(this._taskRepository, {Task task}) {
    setTask(task);
  }

  final Repository<Task> _taskRepository;

  final _task = BehaviorSubject<Task>();

  ValueStream<Task> get task => _task;

  void setTask([Task task]) {
    if (task != null) {
      _task.value = task;
    } else {
      _task.value = Task((builder) {
        builder
          ..id = generateId()
          ..title = ''
          ..isComplete = false;
      });
    }
  }

  void setIsComplete(bool isComplete) {
    _task.value = _task.value.rebuild((b) => b.isComplete = isComplete);
  }

  void setTitle(String title) {
    _task.value = _task.value.rebuild((b) => b.title = title);
  }

  Future<void> save() {
    return _taskRepository.add(task.value);
  }

  Future<void> update() {
    return _taskRepository.add(task.value);
  }

  void dispose() {
    _task.close();
  }
}
