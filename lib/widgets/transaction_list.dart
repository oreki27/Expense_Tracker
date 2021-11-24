import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
        child: (userTransactions.isEmpty) ?
        Column(
          children: <Widget>[
            Text("No transaction added yet",style: Theme.of(context).textTheme.title,),
            Container(child:
              Image.asset('assets/images/shoppingBag.png',fit: BoxFit.cover,),
              height: 200,
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
                    child: FittedBox(child: Text("${userTransactions[index].amount}")),
                  ),
                ),
                title: Text("${userTransactions[index].title}", style: Theme.of(context).textTheme.title,),
                subtitle: Text("${DateFormat.yMMMd().format(userTransactions[index].date)}"),
              ),
            );
          },
        ),
    );
  }
}
