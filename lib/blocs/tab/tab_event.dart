import 'package:equatable/equatable.dart';
import 'package:daily_planner/models/models.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  final AppTab tab;
  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'Tab Updated: {Tab: $tab}';
}
