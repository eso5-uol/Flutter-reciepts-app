import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../validators.dart';

class ChangePasswordPopup extends StatefulWidget {
  @override
  _ChangePasswordPopupState createState() => _ChangePasswordPopupState();
}

class _ChangePasswordPopupState extends State<ChangePasswordPopup> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = "";
  String _password1 = "";
  String _password2 = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return AlertDialog(
      title: Text("Reset your password"),
      content: Form(
        key: _formKey,
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
            ),
            SizedBox(height: 12,),
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text("Reset Password"),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              if (_password1 == _password2){
                dynamic successful = await _auth.changePassword(_password1);
                if (successful == true) {
                  Navigator.of(context).pop();
                }
              } else {
                setState(() => error = "Passwords need to match");
              }
            }
          },
        )
      ],
    );;
  }
}