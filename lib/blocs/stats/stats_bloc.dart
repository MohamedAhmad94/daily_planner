import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:daily_planner/blocs/blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TasksBloc tasksBloc;
  StreamSubscription tasksSubscription;

  StatsBloc({@required this.tasksBloc}) : super(StatsLoading()) {
    void onTasksStateChanged(state) {
      if (state is TasksLoadSuccess) {
        add(StatsUpdated(state.tasks));
      }
    }

    onTasksStateChanged(tasksBloc.state);
    tasksSubscription = tasksBloc.stream.listen(onTasksStateChanged);
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      final activeTasks =
          event.tasks.where((task) => !task.complete).toList().length;
      final completedTasks =
          event.tasks.where((task) => task.complete).toList().length;
      yield StatsLoadSuccess(activeTasks, completedTasks);
    }
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
