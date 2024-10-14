import 'package:flutter/material.dart';
import 'add_todo_page.dart'; // Import the new page
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import 'show_todo_page.dart'; // Import the detail page

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    super.initState();
    _foundToDo = todosList; // Initialize the found list with all items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBody(),
          _buildFloatingActionButton(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: const Text('ToDo App'),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBox(),
          const SizedBox(height: 20),
          const Text(
            'All the things To Do',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundToDo.length,
              itemBuilder: (context, index) {
                return ToDoItem(
                  todo: _foundToDo[index],
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem: _deleteToDoItem,
                  onShowDetails: (ToDo todo) {
                    // Show details when the info button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToDoDetailPage(todo: todo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: _runFilter,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: () async {
            // Navigate to AddToDoPage and wait for the result
            final newToDo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddToDoPage(),
              ),
            );

            // If newToDo is not null, add it to the todo list
            if (newToDo != null) {
              setState(() {
                todosList.add(ToDo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  todoText: newToDo['title'],
                  description: newToDo['description'],
                  dueDate: newToDo['dueDate'],
                  priority: newToDo['priority'],
                ));
                _foundToDo = todosList; // Update _foundToDo to display the latest list
              });
            }
          },
          backgroundColor: tdBlue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone; // Toggle the completion status
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      _foundToDo.removeWhere((item) => item.id == id); // Update _foundToDo
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList; // Show all items if search box is empty
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results; // Update the found list based on the search
    });
  }
}
