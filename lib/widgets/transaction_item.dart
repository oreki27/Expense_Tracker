import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(child: Text("Rs. ${userTransaction.amount}")),
          ),
        ),
        title: Text("${userTransaction.title}", style: Theme.of(context).textTheme.headline6,),
        subtitle: Text("${DateFormat.yMMMd().format(userTransaction.date)}"),
        trailing: MediaQuery.of(context).size.width < 460
            ? IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => deleteTx(userTransaction.id)
        ) : FlatButton.icon(
          icon: Icon(Icons.delete),
          label: Text("Delete"),
          textColor: Theme.of(context).errorColor,
          onPressed: () => deleteTx(userTransaction.id),
        ),
      ),
    );
  }
}