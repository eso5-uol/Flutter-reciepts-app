import 'package:flutter/material.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:fdm_expenses_app/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                        )),
                    RaisedButton(
                        child: Text("Register this account"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    _email, _defaultPassword);
                            if (result == null) {
                              setState(() => error =
                                  "Attempt to register account unsuccessful");
                            } else {
                              try {
                                await _auth.sendPasswordResetEmail(_email);
                                Fluttertoast.showToast(
                                  msg: "Succesfully registered account",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 2,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16,
                                );
                              } catch (e) {
                                setState(() => error =
                                    "Attempt to send password reset email unsuccessful (invalid email?)");
                                print(e); // For debug to console
                              }
                            }
                          }
                        }),
                    Text(error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ))
                  ],
                ))));
  }
}
