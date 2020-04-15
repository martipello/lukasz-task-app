import 'package:built_collection/built_collection.dart';

abstract class Repository<T> {
  Future<void> add(T item);

  Stream<BuiltList<T>> observeAll();

  Stream<T> observeById(String id);

  Future<void> remove(String id);
}
