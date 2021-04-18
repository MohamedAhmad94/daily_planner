import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Task> tasks;

  const StatsUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'Updated Stats: {Tasks: $tasks}';
}
