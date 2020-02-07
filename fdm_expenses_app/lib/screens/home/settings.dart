import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../validators.dart';
import '../../validators.dart';
import '../services/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  resetPasswordAlert(BuildContext context) {
    String _password1 = "";
    String _password2 = "";

    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Reset your password"),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: Validator.emptyPassword,
                onChanged: (value) {
                  setState(() {
                    _password1 = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Please enter a password",
                ),
                obscureText: true,
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: Validator.emptyPassword,
                onChanged: (value) {
                  setState(() {
                    _password2 = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Please confirm your password",
                ),
                obscureText: true,
              )
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Reset Password"),
            onPressed: () {

            },
          )
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              resetPasswordAlert(context);
            },
            child: Text("Change your password"),
          ),
        ],
      ),

    );
  }
}
