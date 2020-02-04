import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String _email = "";
  String _password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign into FDM Expenses"),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(                    //email
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });

                },
              ),
              SizedBox(height: 20,),
              TextFormField(                    //password
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              RaisedButton(                     //button
                color: Colors.pink[400],
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(_email);
                  print(_password);

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}




















