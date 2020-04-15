import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/repository.dart';
import 'package:tasks/utils/task_filter.dart';

class TaskListViewModel {
  TaskListViewModel(this._taskRepository);

  final Repository<Task> _taskRepository;

  final _subscriptions = CompositeSubscription();

  final _filter = BehaviorSubject<String>.seeded(null);

  ValueStream<String> get filter => _filter;

  final _tasks = BehaviorSubject<BuiltList<Task>>();

  ValueStream<BuiltList<Task>> get tasks => _tasks;

  void setFilter(String filter) {
    _filter.value = filter;
  }

  void init() {
    final allTasks = _taskRepository.observeAll();

    final filtered = _filter.switchMap((filter) {
      return allTasks.map((tasks) => tasks.filterByTitle(filter));
    });

    _subscriptions.add(filtered.listen(_tasks.add));
  }

  void dispose() {
    _filter.close();
    _tasks.close();
    _subscriptions.dispose();
  }
}
