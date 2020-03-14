import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdm_expenses_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:fdm_expenses_app/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import '../../models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;

  String _email = "";
  bool _isAdmin = false;
  String _defaultPassword = randomString(10);
  String error = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Register an account"),
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                    validator: Validator.emailSignIn,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Username@fdm.co.uk",
                      labelText: "Email Address",
                    )),
                CheckboxListTile(
                  value: _isAdmin,
                  onChanged: (value) {
                    setState(() {
                      _isAdmin = value;
                    });
                  },
                  title: new Text("Create as Manager"),
                ),
                RaisedButton(
                    child: Text("Register this account"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _defaultPassword = randomString(10);
                        print(_defaultPassword); // for debug
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                _email, _defaultPassword);
                        if (result == "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)") {
                          setState(() => error =
                              "Email already registered");
                        } else if (result == "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)") {
                          setState(() => error =
                          "Email is formatted badly");
                        } else if (result is User) {
//                        else {
                          try {
                            await _auth.resetPassword(_email);
                            String isAdminString = "user";
                            User newUser = result;
                            if (_isAdmin) {
                              isAdminString = "admin";
                            }
                            databaseReference.collection("users")
                                .document(newUser.uid)
                                .setData({
                                  'email': _email,
                                  'role': isAdminString
                            });
                            Fluttertoast.showToast(
                              msg: "Succesfully registered account",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16,
                            );
                            Navigator.of(context, rootNavigator: true)
                                .pop(result);
                          } catch (e) {
                            setState(() => error =
                                "Attempt to send password reset email unsuccessful (invalid email?)");
                            print(e); // For debug to console
                          }
                        } else {
                          setState(() => error =
                          "An error has occured, please try again later");
                        }
                      }
                    }),
                Text(error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ))
              ],
            )));
  }
}
