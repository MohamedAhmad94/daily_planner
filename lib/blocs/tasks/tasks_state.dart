import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksLoading extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<Task> tasks;

  const TasksLoadSuccess([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'Tasks Load Succeeded {Tasks: $tasks}';
}

class TasksLoadFailure extends TasksState {}
