// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:todo_app_firebase/thme/colors.dart';

class AlertBox extends StatelessWidget {
  final TextEditingController controllerTask;
  final VoidCallback onSave;
  final String? initialValue;
  final bool isDarkMode;

  AlertBox({
    super.key,
    required this.controllerTask,
    required this.onSave,
    required this.isDarkMode,
    this.initialValue,
  }) {
    if (initialValue != null) {
      controllerTask.text = initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode ? DarkTheme.bg: LightTheme.bg;
    final hintTextColor =
        isDarkMode ? DarkTheme.hintText : LightTheme.hintText;
    final textColor =
        isDarkMode ? DarkTheme.primaryText : LightTheme.primaryText;
    final borderColor = isDarkMode ? Colors.white : Colors.black;

    return AlertDialog(
      backgroundColor: backgroundColor,
      content: Stack(
        children: [
          Container(
            height: 120,
            child: Column(
              children: [
                TextField(
                  controller: controllerTask,
                  decoration: InputDecoration(
                    label: Text("New task",style: TextStyle(color: hintTextColor),),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onSave();
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.navigate_next_rounded,
                        color: isDarkMode
                            ? hintTextColor 
                            : LightTheme.primaryBackground,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? DarkTheme.accentColor
                            : LightTheme.accentColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
