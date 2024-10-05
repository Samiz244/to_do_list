import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Define a list of tasks as an instance variable
  List<Task> tasks = [
    Task(name: 'Buy groceries'),
    Task(name: 'Walk the dog'),
    Task(name: 'Complete Flutter project'),
  ];

  // Method to add a new task
  void _addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  // Method to mark a task as completed
  void _completeTask(int index) {
    setState(() {
      tasks[index].isCompleted = true;
    });
  }

  // Method to remove a task
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Build the UI for the task list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Button to mark the task as completed
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: tasks[index].isCompleted
                            ? null
                            : () => _completeTask(index),
                      ),
                      // Button to remove the task
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter new task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _addTask(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TaskListScreen(),
  ));
}
