// main_page.dart

// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/thme/colors.dart';
import 'package:todo_app_firebase/util/alert_box.dart';
import 'package:todo_app_firebase/util/toDoList.dart';

class ToDoApp extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  const ToDoApp({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  void onClick(String id, bool currentValue) async {
    await tasks.doc(id).update({'completed': !currentValue});
  }

  void onSave(TextEditingController controller) async {
    if (controller.text.isNotEmpty) {
      await tasks.add({'name': controller.text, 'completed': false});
      Navigator.of(context).pop();
    }
  }

  void newTask() {
    TextEditingController _controllerTask = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertBox(
          controllerTask: _controllerTask,
          onSave: () => onSave(_controllerTask),
          isDarkMode: widget.isDarkMode,
        );
      },
    );
  }

  void onEdit(BuildContext context, String id, String currentName) {
    TextEditingController _editController =
        TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) {
        return AlertBox(
          controllerTask: _editController,
          onSave: () async {
            if (_editController.text.isNotEmpty) {
              await tasks.doc(id).update({'name': _editController.text});
              Navigator.of(context).pop();
            }
          },
          isDarkMode: widget.isDarkMode,
          initialValue: currentName,
        );
      },
    );
  }

  void onDelete(BuildContext context, String id) async {
    await tasks.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? DarkTheme.primaryBackground
          : LightTheme.primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "To Do",
          style: TextStyle(
            color: widget.isDarkMode ? DarkTheme.icone : LightTheme.tText,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: widget.isDarkMode ? DarkTheme.icone : LightTheme.icone,
            ),
            onPressed: () {
              setState(() {
                widget.onThemeChanged(!widget.isDarkMode);
              });
            },
          ),
        ],
        elevation: .5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newTask,
        child: Icon(
          Icons.add,
          color: widget.isDarkMode
              ? DarkTheme.primaryBackground
              : LightTheme.primaryBackground,
        ),
        backgroundColor:
            widget.isDarkMode ? DarkTheme.accentColor : LightTheme.accentColor,
      ),
      body: StreamBuilder(
        stream: tasks.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var task = snapshot.data!.docs[index];
              return toDoList(
                taskName: task['name'],
                valueCheck: task['completed'],
                onClick: (value) => onClick(task.id, task['completed']),
                onDelete: (context) => onDelete(context, task.id),
                onEdit: (context) => onEdit(context, task.id, task['name']),
                isDarkMode: widget.isDarkMode,
              );
            },
          );
        },
      ),
    );
  }
}
