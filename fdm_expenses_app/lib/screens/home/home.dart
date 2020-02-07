import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/custom_bottom_navigation.dart';
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

    return Container(
      child: Column(
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
