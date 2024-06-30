import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/provider.dart';
import 'package:todo_list_app/model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 40),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 33),
            child: Center(
              child: Text(
                'TO-DO LIST',
                style: TextStyle(
                  color: const Color.fromARGB(255, 142, 167, 143),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Consumer<ToDoProvider>(
                      builder: (context, todoProvider, child) {
                        return ListView.builder(
                          itemCount: todoProvider.todos.length,
                          itemBuilder: (context, index) {
                            final todo = todoProvider.todos[index];
                            return Slidable(
                              key: ValueKey(todo.id),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) => _showEditDialog(
                                        context, todoProvider, todo),
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) =>
                                        todoProvider.deleteTask(todo.id),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Checkbox(
                                          value: todo.isCompleted,
                                          onChanged: (_) => todoProvider
                                              .toggleTaskStatus(todo.id),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          checkColor: Colors.black,
                                          fillColor: MaterialStateProperty.all(
                                              Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(todo.task),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            right: 20, bottom: 80), // Adjust the margin as needed
        child: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          backgroundColor: const Color.fromARGB(255, 142, 167, 143),
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Change background color
          title: Text(
            'Add Task',
            style: TextStyle(
              color: const Color.fromARGB(255, 142, 167, 143),
            ), // Change text color
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter task',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 191, 207, 192),
              ), // Change hint text color
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: const Color.fromARGB(255, 142, 167, 143),
                ), // Change text color
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ToDoProvider>(context, listen: false)
                    .addTask(_controller.text);
                Navigator.of(context).pop();
                _controller.clear();
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: const Color.fromARGB(255, 142, 167, 143),
                ), // Change text color
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(
      BuildContext context, ToDoProvider todoProvider, ToDo todo) {
    _controller.text = todo.task;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter new task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoProvider.editTask(todo.id, _controller.text);
                Navigator.of(context).pop();
                _controller.clear();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
