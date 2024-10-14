import 'package:flutter/material.dart';
import '../model/todo.dart'; // Import the ToDo model

class ToDoDetailPage extends StatelessWidget {
  final ToDo todo;

  // Constructor to receive the selected todo item
  ToDoDetailPage({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${todo.todoText ?? 'No Title'}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${todo.description ?? 'No description provided'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Due Date: ${todo.dueDate != null ? todo.dueDate.toString().split(' ')[0] : 'No due date'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Priority: ${todo.priority ?? 'No priority assigned'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Status: ${todo.isDone ? 'Completed' : 'Incomplete'}',
              style: TextStyle(
                fontSize: 18,
                color: todo.isDone ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
