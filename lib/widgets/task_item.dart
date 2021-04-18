import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/models/models.dart';

class TaskItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckBoxChanged;
  final Task task;

  TaskItem(
      {Key key,
      @required this.onDismissed,
      @required this.onTap,
      @required this.onCheckBoxChanged,
      @required this.task})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.todoItem(task.id),
      onDismissed: onDismissed,
      child: ListTile(
        leading: Checkbox(
          key: ArchSampleKeys.todoItemCheckbox(task.id),
          value: task.complete,
          onChanged: onCheckBoxChanged,
        ),
        title: Hero(
            tag: '${task.id}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                task.task,
                key: ArchSampleKeys.todoItemTask(task.id),
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        subtitle: task.note.isNotEmpty
            ? Text(
                task.note,
                key: ArchSampleKeys.todoItemNote(task.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
