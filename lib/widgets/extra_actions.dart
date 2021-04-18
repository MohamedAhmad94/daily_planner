import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/daily_planner_keys.dart';
import 'package:daily_planner/models/models.dart';
import 'package:daily_planner/blocs/tasks/tasks.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadSuccess) {
          bool allComplete =
              (BlocProvider.of<TasksBloc>(context).state as TasksLoadSuccess)
                  .tasks
                  .every((task) => task.complete);
          return PopupMenuButton<ExtraAction>(
            key: DailyPlannerKeys.extraActionsButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<TasksBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TasksBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? ArchSampleLocalizations.of(context).markAllIncomplete
                      : ArchSampleLocalizations.of(context).markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                  key: ArchSampleKeys.clearCompleted,
                  value: ExtraAction.clearCompleted,
                  child: Text(
                    ArchSampleLocalizations.of(context).clearCompleted,
                  )),
            ],
          );
        }
        return Container(key: DailyPlannerKeys.extraActionsEmptyContainer);
      },
    );
  }
}
