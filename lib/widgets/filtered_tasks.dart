import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/blocs/blocs.dart';
import 'package:daily_planner/widgets/widgets.dart';
import 'package:daily_planner/screens/screens.dart';
import 'package:daily_planner/daily_planner_keys.dart';

class FilteredTasks extends StatelessWidget {
  FilteredTasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
      builder: (context, state) {
        if (state is FilteredTasksLoading) {
          return LoadingIndicator(key: ArchSampleKeys.todosLoading);
        } else if (state is FilteredTasksLoadSuccess) {
          final tasks = state.filteredTasks;
          return ListView.builder(
              key: ArchSampleKeys.todoList,
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];
                return TaskItem(
                    onDismissed: (direction) {
                      BlocProvider.of<TasksBloc>(context)
                          .add(TaskDeleted(task: task));
                      ScaffoldMessenger.of(context).showSnackBar(
                          DeleteTaskSnackBar(
                              key: ArchSampleKeys.snackbar,
                              task: task,
                              onUndo: () => BlocProvider.of<TasksBloc>(context)
                                  .add(TaskAdded(task: task)),
                              localizations: localizations));
                    },
                    onTap: () async {
                      final removedTask = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return Details(id: task.id);
                        }),
                      );
                      if (removedTask != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            DeleteTaskSnackBar(
                                key: ArchSampleKeys.snackbar,
                                task: task,
                                onUndo: () =>
                                    BlocProvider.of<TasksBloc>(context)
                                        .add(TaskAdded(task: task)),
                                localizations: localizations));
                      }
                    },
                    onCheckBoxChanged: (_) {
                      BlocProvider.of<TasksBloc>(context).add(TaskUpdated(
                          task: task.copyWith(complete: !!task.complete)));
                    },
                    task: task);
              });
        } else {
          return Container(key: DailyPlannerKeys.filteredTasksEmptyContainer);
        }
      },
    );
  }
}
