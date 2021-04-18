import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_planner/localization.dart';
import 'package:daily_planner/widgets/widgets.dart';
import 'package:daily_planner/blocs/blocs.dart';
import 'package:daily_planner/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
      return Scaffold(
        appBar: AppBar(
          title: Text(FlutterBlocLocalizations.of(context).appTitle),
          actions: [
            FilterButton(visible: activeTab == AppTab.tasks),
            ExtraActions(),
          ],
        ),
        body: activeTab == AppTab.tasks ? FilteredTasks() : Stats(),
        floatingActionButton: FloatingActionButton(
          key: ArchSampleKeys.addTodoFab,
          onPressed: () {
            Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
          },
          child: Icon(Icons.add),
          tooltip: ArchSampleLocalizations.of(context).addTodo,
        ),
        bottomNavigationBar: TabSelector(
          activeTab: activeTab,
          onTabSelected: (tab) =>
              BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
        ),
      );
    });
  }
}
