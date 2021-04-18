import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_planner/blocs/tasks/tasks.dart';
import 'package:daily_planner/screens/screens.dart';
import 'package:daily_planner/daily_planner_keys.dart';
import 'package:todos_app_core/todos_app_core.dart';

class Details extends StatelessWidget {
  final String id;
  Details({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      final task = (state as TasksLoadSuccess)
          .tasks
          .firstWhere((task) => task.id == id, orElse: () => null);
      final localizations = ArchSampleLocalizations.of(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.todoDetails),
          actions: [
            IconButton(
                tooltip: localizations.deleteTodo,
                key: ArchSampleKeys.deleteTodoButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TasksBloc>(context)
                      .add(TaskDeleted(task: task));
                  Navigator.pop(context, task);
                }),
          ],
        ),
        body: task == null
            ? Container(key: DailyPlannerKeys.emptyDetaiesContainer)
            : Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Checkbox(
                              key: DailyPlannerKeys.detailsScreenCheckBox,
                              value: task.complete,
                              onChanged: (_) {
                                BlocProvider.of<TasksBloc>(context).add(
                                  TaskUpdated(
                                    task:
                                        task.copyWith(complete: !task.complete),
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: '${task.id}__heroTag',
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 16.0),
                                  child: Text(
                                    task.task,
                                    key: ArchSampleKeys.detailsTodoItemTask,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                              Text(
                                task.note,
                                key: ArchSampleKeys.detailsTodoItemNote,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          key: ArchSampleKeys.addTodoFab,
          tooltip: localizations.editTodo,
          child: Icon(Icons.edit),
          onPressed: task == null
              ? null
              : () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddTask(
                      key: ArchSampleKeys.editTodoScreen,
                      onSave: (taskDescription, note) {
                        BlocProvider.of<TasksBloc>(context).add(TaskUpdated(
                            task: task.copyWith(
                                task: taskDescription, note: note)));
                      },
                      isEditing: true,
                      task: task,
                    );
                  }));
                },
        ),
      );
    });
  }
}
