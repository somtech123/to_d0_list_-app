import 'package:flutter/material.dart';
import './Widget/todo.dart';
import './model/transaction.dart';
import './Widget/add_todo_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'ToDo List';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final List<Transaction> _list = [
    // Transaction(title: 'shopping', date: DateTime.now()),
    // Transaction(title: 'traveling', date: DateTime.now())
  ];

  void _addNewTransaction(String title, DateTime date) {
    final newTx =
        Transaction(title: title, date: date, id: DateTime.now().toString());
    setState(() {
      _list.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddItem(_addNewTransaction),
          );
        });
  }

  void _deletetx(String id) {
    setState(() {
      _list.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Todo(_list, _deletetx)],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
