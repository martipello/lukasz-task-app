import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'task.g.dart';

abstract class Task implements Built<Task, TaskBuilder> {
  static Serializer<Task> get serializer => _$taskSerializer;

  String get id;

  String get title;

  bool get isComplete;

  Task._();

  factory Task([void Function(TaskBuilder) updates]) = _$Task;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Task.serializer, this);
  }

  static Task fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Task.serializer, json);
  }
}
