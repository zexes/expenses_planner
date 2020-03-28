import 'dart:io';

import 'package:expenses_planner/utility/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './constants/constants.dart';
import './model/transaction.dart';
import './widgets/chart.dart';

void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
//        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: kThemeText.copyWith(fontSize: 18),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: kThemeText,
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(
//        id: "t1", title: 'New Shoes', amount: 69.99, date: DateTime.now()),
//    Transaction(
//        id: "t2",
//        title: 'Weekly Groceries',
//        amount: 16.53,
//        date: DateTime.now().subtract(Duration(days: 3))),
//    Transaction(
//        id: "t2",
//        title: 'Lager number Grocery',
//        amount: 30.53,
//        date: DateTime.now().subtract(Duration(days: 1)))
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

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: selectedDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    MyAlert(
      context: context,
      onPressed: () {
        setState(() {
          _userTransactions.removeWhere((tx) => tx.id == id);
        });
        Navigator.of(context).pop();
      },
    ).executeAlert();
  }

  void _deleteTransaction2(int index) {
    MyAlert(
      context: context,
      onPressed: () {
        setState(() {
          _userTransactions.removeAt(index);
        });
        Navigator.of(context).pop();
      },
    ).executeAlert();
  }

  Widget buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize:
                  MainAxisSize.min, //IOS Navigation Bar to show other content
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = buildAppBar();

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
          transactions: _userTransactions,
          deleteTxn: _deleteTransaction,
          deleteTxn2: _deleteTransaction2),
    );

    Container chartAboveList(double height) {
      return Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              height,
          child: Chart(recentTransactions: _recentTransactions));
    }

    Widget switchMode() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'show chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      );
    }

    List<Widget> _buildPortraitContent(double height) {
      return [chartAboveList(height), txList];
    }

    List<Widget> _buildLandScapeContent(double height) {
      return [switchMode(), _showChart ? chartAboveList(height) : txList];
    }

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        //Single Child Scroll Implemented here
        child: Column(
          children: <Widget>[
            if (isLandscape) ..._buildLandScapeContent(0.7),
            if (!isLandscape) ..._buildPortraitContent(0.3),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    tooltip: 'Add new Transaction',
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
