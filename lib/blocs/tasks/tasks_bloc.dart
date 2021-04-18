import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_planner/blocs/tasks/tasks.dart';
import 'package:daily_planner/models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TodosRepositoryFlutter todosRepository;

  TasksBloc({this.todosRepository}) : super(TasksLoading());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is TasksLoaded) {
      yield* _mapTasksLoadedtoState();
    } else if (event is TaskAdded) {
      yield* _mapTaskAddedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event);
    } else if (event is TaskDeleted) {
      yield* _mapTaskDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TasksState> _mapTasksLoadedtoState() async* {
    try {
      final tasks = await this.todosRepository.loadTodos();
      yield TasksLoadSuccess(
        tasks.map(Task.fromEntity).toList(),
      );
    } catch (_) {
      yield TasksLoadFailure();
    }
  }

  Future _saveTasks(List<Task> tasks) {
    return todosRepository.saveTodos(
      tasks.map((task) => task.toEntity()).toList(),
    );
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          List.from((state as TasksLoadSuccess).tasks)..add(event.task);
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.id != event.task.id)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapToggleAllToState() async* {
    if (state is TasksLoadSuccess) {
      final allCompleted =
          (state as TasksLoadSuccess).tasks.every((task) => task.complete);
      final List<Task> updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .map((task) => task.copyWith(complete: !allCompleted))
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapClearCompletedToState() async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => !task.complete)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }
}
