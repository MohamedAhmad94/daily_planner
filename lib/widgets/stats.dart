import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/blocs/stats/stats.dart';
import 'package:daily_planner/widgets/widgets.dart';
import 'package:daily_planner/daily_planner_keys.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return LoadingIndicator(key: DailyPlannerKeys.statsLoadingIndicator);
        } else if (state is StatsLoadSuccess) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      ArchSampleLocalizations.of(context).completedTodos,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text('${state.completedTasks}',
                      key: ArchSampleKeys.statsNumCompleted,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(ArchSampleLocalizations.of(context).activeTodos,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text('${state.activeTasks}',
                      key: ArchSampleKeys.statsNumActive,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ],
            ),
          );
        } else {
          return Container(key: DailyPlannerKeys.emptyStatsContainer);
        }
      },
    );
  }
}
