import 'package:flutter/material.dart';
import 'package:daily_planner/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';

typedef OnSaveCallback = Function(String taskDescription, String note);

class AddTask extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Task task;

  AddTask({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.task,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _taskDescription;
  String _note;

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? localizations.editTodo : localizations.addTodo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: isEditing ? widget.task.task : '',
                  key: ArchSampleKeys.taskField,
                  autofocus: !isEditing,
                  style: textTheme.headline5,
                  decoration: InputDecoration(
                    hintText: localizations.newTodoHint,
                  ),
                  validator: (val) {
                    return val.trim().isEmpty
                        ? localizations.emptyTodoError
                        : null;
                  },
                  onSaved: (value) => _taskDescription = value,
                ),
                TextFormField(
                  initialValue: isEditing ? widget.task.note : '',
                  key: ArchSampleKeys.noteField,
                  maxLines: 10,
                  style: textTheme.subtitle1,
                  decoration: InputDecoration(
                    hintText: localizations.notesHint,
                  ),
                  onSaved: (value) => _note = value,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_taskDescription, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
