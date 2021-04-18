import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:daily_planner/models/models.dart';

class DeleteTaskSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteTaskSnackBar({
    Key key,
    @required Task task,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.todoDetails,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(label: localizations.undo, onPressed: onUndo),
        );
}
