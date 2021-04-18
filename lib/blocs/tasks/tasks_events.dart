import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object> get props => [];
}

class TasksLoaded extends TasksEvent {}

class TaskAdded extends TasksEvent {
  final Task task;
  const TaskAdded({this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'Task Added {Task: $task}';
}

class TaskUpdated extends TasksEvent {
  final Task task;
  const TaskUpdated({this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'Task Updated {Updated Task: $task}';
}

class TaskDeleted extends TasksEvent {
  final Task task;
  const TaskDeleted({this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'Task Deleted {Deleted Task: $task}';
}

class ClearCompleted extends TasksEvent {}

class ToggleAll extends TasksEvent {}
