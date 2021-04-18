import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class StatsLoadSuccess extends StatsState {
  final int activeTasks;
  final int completedTasks;

  const StatsLoadSuccess(this.activeTasks, this.completedTasks);

  @override
  List<Object> get props => [activeTasks, completedTasks];

  @override
  String toString() {
    return 'Stats Load Succeeded: {Active Tasks: $activeTasks, Completed Tasks: $completedTasks}';
  }
}
