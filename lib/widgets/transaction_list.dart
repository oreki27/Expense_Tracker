import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (userTransactions.isEmpty) ?
      LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("No transaction added yet",style: Theme.of(context).textTheme.headline6,),
                SizedBox(
                  height: 10,
                ),
                Container(child:
                Image.asset('assets/images/shoppingBag.png',fit: BoxFit.cover,),
                  height: constraints.maxHeight * 0.6,
                )
              ],
            );
          }
      )
      :ListView.builder(
        itemCount: userTransactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(child: Text("Rs. ${userTransactions[index].amount}")),
                ),
              ),
              title: Text("${userTransactions[index].title}", style: Theme.of(context).textTheme.headline6,),
              subtitle: Text("${DateFormat.yMMMd().format(userTransactions[index].date)}"),
              trailing: MediaQuery.of(context).size.width < 460
                  ? IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(userTransactions[index].id)
              ) : FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTx(userTransactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
