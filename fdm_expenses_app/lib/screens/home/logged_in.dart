import 'package:fdm_expenses_app/screens/home/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../services/auth.dart';
import '../services/auth.dart';
import 'home.dart';
import 'home.dart';

class LoggedIn extends StatefulWidget {
  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {

  Widget selectScreen(User user) {
    switch (user.currentIndex){
      case 0: return Home();
      case 1: return Settings();
      default: return Home();
    }
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
      body: selectScreen(user),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: user.currentIndex,
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
        onTap: (index) {
          setState(() {
            user.currentIndex = index;
            print(user.currentIndex);
          });
        },
      ),
    );


  }
}
