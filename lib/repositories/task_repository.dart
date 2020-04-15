import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/repository.dart';

class TaskRepository implements Repository<Task> {
  TaskRepository({Iterable<Task> items}) {
    _data.value = BuiltMap<String, Task>();
    _data.listen((data) => print(data));
  }

  final _data = BehaviorSubject<BuiltMap<String, Task>>();

  @override
  Future<void> add(Task task) async {
    _data.value = _data.value.rebuild((b) => b[task.id] = task);
  }

  Future<void> addAll(Iterable<Task> tasks) async {
    _data.value = _data.value.rebuild((b) {
      for (final task in tasks) {
        b[task.id] = task;
      }
    });
  }

  @override
  Stream<BuiltList<Task>> observeAll() {
    return _data.map((data) => data.values.toBuiltList());
  }

  @override
  Stream<Task> observeById(String id) {
    return observeAll().map((items) => items.firstWhere((i) => i.id == id));
  }

  @override
  Future<void> remove(String id) async {
    _data.value = _data.value.rebuild((b) => b.remove(id));
  }

  Future<void> removeAllComplete() async {
    _data.value = _data.value.rebuild((b) {
      b.removeWhere((_, task) => task.isComplete);
    });
  }

  Future<void> removeAll() async {
    _data.value = BuiltMap<String, Task>();
  }
}
