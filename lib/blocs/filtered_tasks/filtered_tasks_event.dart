import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class FilteredTasksEvent extends Equatable {
  const FilteredTasksEvent();
}

class FilterUpdated extends FilteredTasksEvent {
  final VisibilityFilter filter;
  const FilterUpdated({this.filter});

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'Filter Updated {Filter: $filter}';
}

class TasksUpdated extends FilteredTasksEvent {
  final List<Task> tasks;

  const TasksUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'Tasks Updated: {Tasks: $tasks}';
}
