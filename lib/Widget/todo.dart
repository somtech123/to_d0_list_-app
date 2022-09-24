import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:intl/intl.dart';

class Todo extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletx;
  Todo(this.transaction, this.deletx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? EmptyWidget(
              packageImage: PackageImage.Image_1,
              title: 'we are sorry',
              subTitle: 'no item added',
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deletx(transaction[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text(
                                transaction[index].title[0].toUpperCase())),
                      ),
                    ),
                    title: Text(transaction[index].title),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transaction[index].date)),
                  ),
                );
              }),
              itemCount: transaction.length,
            ),
    );
  }
}
