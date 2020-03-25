import 'package:fdm_expenses_app/screens/form/expenseForm.dart';
import 'package:fdm_expenses_app/screens/home/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../services/auth.dart';
import '../services/auth.dart';
import 'home.dart';
import 'home.dart';
import 'settings.dart';

class LoggedIn extends StatefulWidget {
  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {

  int _currentIndex =0;
  int _selectedIndex = 0;

  final List<Widget> _children = [
    Home(), Settings(),
  ];

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("FDM Expenses"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Log out"),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex ==0
          ? FloatingActionButton.extended(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpenseForm()),
        );
      },
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        elevation: 20.0,
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      )
          :Container(
        width: 0,
        height: 0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          )
        ],
      ),
    );
  }
}
