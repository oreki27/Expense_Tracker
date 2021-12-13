import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import '/widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      debugShowCheckedModeBanner : false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput = "";
  // String amountInput = "";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1',
    //     title: "New Shoes",
    //     amount: 56.22,
    //     date: DateTime.now()
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        },
    );
  }

  // List<bool> lst = [false,false];

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final bool isLandscape = mQ.orientation == Orientation.landscape;
    final dynamic appBar = (Platform.isIOS

  ?  CupertinoNavigationBar(
      middle: Text("Personal Expenses"),
      trailing: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _startAddNewTransaction(context),
              child: Icon(CupertinoIcons.add),
            ),
          ],
        mainAxisSize: MainAxisSize.min,
        ),
    )
  :  AppBar(
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    ));
    final txnListWidget = Container(
      child: TransactionList(_userTransactions,_deleteTransaction),
      height: (mQ.size.height - appBar.preferredSize.height) * 0.55,
    );
    final chartWidgetLand = Container(
      child: Chart(_recentTransactions),
      height: (mQ.size.height - appBar.preferredSize.height) * 0.6,
    );

    final chartWidgetPotr = Container(
      child: Chart(_recentTransactions),
      height: (mQ.size.height - appBar.preferredSize.height) * 0.25,
    );

    final pageBody = SafeArea(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if(isLandscape) Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Show Chart",
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch.adaptive(value: _showChart, onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
          ],
        ),
        if(isLandscape) _showChart ? chartWidgetLand
            : txnListWidget,
        if(!isLandscape) chartWidgetPotr,
        if(!isLandscape) txnListWidget,
      ],
    ));
    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    )
        : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
