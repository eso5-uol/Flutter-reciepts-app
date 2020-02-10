import 'package:flutter/material.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:fdm_expenses_app/validators.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _defaultPassword = "default";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("FDM Expenses"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: Validator.emptyEmail,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Username@fdm.co.uk",
                  labelText: "Email Address",
                )
              ),
              RaisedButton(
                child: Text(
                  "Register this account"
                )
              )
            ],
          )
        )
      )
    );
  }
}