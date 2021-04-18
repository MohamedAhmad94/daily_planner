import 'package:daily_planner/blocs/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/localization.dart';
import 'package:daily_planner/blocs/blocs.dart';
import 'package:daily_planner/models/models.dart';
import 'package:daily_planner/screens/screens.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return TasksBloc(
          todosRepository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TasksLoaded());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(create: (context) => TabBloc()),
              BlocProvider<FilteredTasksBloc>(
                create: (context) => FilteredTasksBloc(
                  tasksBloc: BlocProvider.of<TasksBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  tasksBloc: BlocProvider.of<TasksBloc>(context),
                ),
              ),
            ],
            child: HomePage(),
          );
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddTask(
              key: ArchSampleKeys.addTodoScreen,
              onSave: (taskDescription, note) {
                BlocProvider.of<TasksBloc>(context)
                    .add(TaskAdded(task: Task(taskDescription, note: note)));
              },
              isEditing: false);
        }
      },
    );
  }
}
