import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class FilteredTasksState extends Equatable {
  const FilteredTasksState();

  @override
  List<Object> get props => [];
}

class FilteredTasksLoading extends FilteredTasksState {}

class FilteredTasksLoadSuccess extends FilteredTasksState {
  final List<Task> filteredTasks;
  final VisibilityFilter activeFilter;

  const FilteredTasksLoadSuccess(this.filteredTasks, this.activeFilter);

  @override
  List<Object> get props => [filteredTasks, activeFilter];

  @override
  String toString() {
    return 'Filtered Tasks Load Succeeded: {Filtered Tasks: $filteredTasks, Active Filter: $activeFilter}';
  }
}
