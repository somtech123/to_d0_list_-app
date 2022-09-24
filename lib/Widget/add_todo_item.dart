import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddItem extends StatefulWidget {
  final Function addToDo;
  AddItem(this.addToDo);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  void _submitDate() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty || _selectedDate == null) {
      return;
    } else {
      widget.addToDo(enteredText, _selectedDate);
      Navigator.of(context).pop();
    }
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2040))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Add item'),
            controller: _titleController,
            onEditingComplete: _submitDate,
          ),
          Container(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No Date Chosen'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
              ),
              TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Choose Date'))
            ]),
          ),
          ElevatedButton(
              onPressed: _submitDate, child: const Text('Add element'))
        ]),
      ),
    );
  }
}
