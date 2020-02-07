import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
//  final User user;
//
//  Home({this.user});

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("FDM Expenses"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text("Log out"),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.red,
            child: Text("Reset password"),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Please Sign in again with the new password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 2,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16,
              );
              _auth.resetPassword(user.email);
              _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
