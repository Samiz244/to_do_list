import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

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

  // Method to add a new tasks
  void _addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  // Method to mark tasks as completed
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
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
        title: const Text('Task List'),
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

                  leading: Checkbox(
                    value: tasks[index].isCompleted,  // [Checkbox to show completion status]
                    onChanged: (value) {
                      _toggleTaskCompletion(index);  // [Toggle task completion on checkbox change]
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTask(index),  // [Remove task when Delete button is pressed]
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter new task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _addTask(value); // [Add new task on submission]
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // [Add task when Add button is tapped]
                    final controller = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Task'),
                          content: TextField(
                            controller: controller,
                            decoration: InputDecoration(labelText: 'Task Name'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  _addTask(controller.text);
                                }
                                Navigator.of(context).pop(); // [Close dialog]
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
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
