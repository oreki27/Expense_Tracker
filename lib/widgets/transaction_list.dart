import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            height: constraints.maxHeight * 0.1,
            child: (userTransactions.isEmpty) ?
            Column(
              children: <Widget>[
                Text("No transaction added yet",style: Theme.of(context).textTheme.headline6,),
                Container(child:
                Image.asset('assets/images/shoppingBag.png',fit: BoxFit.cover,),
                  height: constraints.maxHeight * 0.4,
                )
              ],
            ) :ListView.builder(
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
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(userTransactions[index].id),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}
