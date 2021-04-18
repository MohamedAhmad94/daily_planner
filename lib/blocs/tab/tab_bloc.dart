import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_planner/blocs/tab/tab.dart';
import 'package:daily_planner/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.tasks);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
