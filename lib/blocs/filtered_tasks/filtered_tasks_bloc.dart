import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:daily_planner/blocs/filtered_tasks/filtered_tasks.dart';
import 'package:daily_planner/blocs/tasks/tasks.dart';
import 'package:daily_planner/models/models.dart';

class FilteredTasksBloc extends Bloc<FilteredTasksEvent, FilteredTasksState> {
  final TasksBloc tasksBloc;
  StreamSubscription tasksSubscription;

  FilteredTasksBloc({@required this.tasksBloc})
      : super(
          tasksBloc.state is TasksLoadSuccess
              ? FilteredTasksLoadSuccess(
                  (tasksBloc.state as TasksLoadSuccess).tasks,
                  VisibilityFilter.all,
                )
              : FilteredTasksLoading(),
        ) {
    tasksSubscription = tasksBloc.stream.listen((state) {
      if (state is TasksLoadSuccess) {
        add(TasksUpdated((tasksBloc.state as TasksLoadSuccess).tasks));
      }
    });
  }

  @override
  Stream<FilteredTasksState> mapEventToState(FilteredTasksEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapTasksUpdatedToState(event);
    }
  }

  Stream<FilteredTasksState> _mapFilterUpdatedToState(
      FilterUpdated event) async* {
    if (tasksBloc.state is TasksLoadSuccess) {
      yield FilteredTasksLoadSuccess(
          _mapTasksToFilteredTasks(
              (tasksBloc.state as TasksLoadSuccess).tasks, event.filter),
          event.filter);
    }
  }

  Stream<FilteredTasksState> _mapTasksUpdatedToState(
      TasksUpdated event) async* {
    final visibilityFilter = state is FilteredTasksLoadSuccess
        ? (state as FilteredTasksLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredTasksLoadSuccess(
        _mapTasksToFilteredTasks(
            (tasksBloc.state as TasksLoadSuccess).tasks, visibilityFilter),
        visibilityFilter);
  }

  List<Task> _mapTasksToFilteredTasks(
      List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !task.complete;
      } else {
        return task.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
