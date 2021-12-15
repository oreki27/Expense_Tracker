import 'package:flutter/material.dart';
import './transaction_item.dart';
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
          return TransactionItem(userTransaction: userTransactions[index], deleteTx: deleteTx);
        },
      ),
    );
  }
}
