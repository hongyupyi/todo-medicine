import 'package:flutter/material.dart';

class ToDo {
  bool isDone = false; //current progress
  String title; //works

  ToDo(this.title);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _items = <ToDo>[]; // saving list of things to do
  var _todoController = TextEditingController(); //Controller of saving list

  void _addTodo(ToDo toDo) { //Add things to do
    setState(() {
      _items.add(toDo);
      _todoController.text = '';
    });
  }

  void _deleteTodo(ToDo toDo) { //delete things to do
    setState(() {
      _items.remove(toDo);
    });
  }

  void _toggleTodo(ToDo toDo) { //check things to do
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Things to do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: _todoController,
                    ),
                ),
                RaisedButton(
                    onPressed: () => _addTodo(ToDo(_todoController.text)),
                    color: Colors.indigo,
                    child: Text('add', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                Expanded(
                    child: ListView(
                      children: _items.map((todo) => _buildItemWidget(todo)).toList(),
                ),
                )
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(ToDo toDo) {
    return ListTile(
      onTap: () => _toggleTodo(toDo), // Complete/Cancel if click
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteTodo(toDo), //delete things to do
      ),
      title: Text(
        toDo.title,
        style: toDo.isDone? //Complete or not
          TextStyle(
            decoration: TextDecoration.lineThrough, //Cancel line
            fontStyle: FontStyle.italic,
          ) : null,
      ),
    );
  }
}