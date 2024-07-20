// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_firebase/thme/colors.dart';

class toDoList extends StatelessWidget {
  final String taskName;
  final bool valueCheck;
  final Function(bool?)? onClick;
  final Function(BuildContext)? onDelete;
  final Function(BuildContext)? onEdit;
  final bool isDarkMode;

  toDoList({
    super.key,
    required this.taskName,
    required this.valueCheck,
    required this.onClick,
    required this.onDelete,
    required this.onEdit,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onEdit!(context),
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SizedBox(width: 8),
            SlidableAction(
              onPressed: (context) => onDelete!(context),
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ],
        ),
        child: Container(
          child: Row(
            children: [
              Checkbox(
                value: valueCheck,
                onChanged: onClick,
                activeColor:
                    isDarkMode ? DarkTheme.primaryText : LightTheme.activeState,
                checkColor: isDarkMode
                    ? DarkTheme.accentColor
                    : LightTheme.primaryBackground,
              ),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: valueCheck
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: isDarkMode
                      ? DarkTheme.primaryText
                      : LightTheme.activeState,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: isDarkMode
                ? DarkTheme.accentColor
                : LightTheme.elementBackground,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
