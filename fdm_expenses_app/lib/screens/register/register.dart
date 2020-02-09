import 'package:flutter/material.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

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
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back'),
        )
      )
    );
  }
}