import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:fdm_expenses_app/validators.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String error = "";
  var passwordMap = {};
  int accountLockNumber = 5; //number of incorrect attempts user has before locked out

  resetPasswordLinkAlert(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Enter your email to reset the password"),
        content: TextField(
          controller: customController,
          decoration: const InputDecoration(
            labelText: "Email Address",
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Submit"),
            onPressed: () {
              _auth.resetPassword(customController.text.toString());
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign into FDM Expenses"),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                validator: Validator.emailSignIn,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "@fdm.co.uk",
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: Validator.emptyPassword,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() => error = " ");
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
                    if (result == "PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)" ||
                                result == "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)") {
                      HapticFeedback.vibrate();
                      setState(() => error = "Incorrect Login Details!");

                      if (passwordMap[_email] == accountLockNumber - 1) {
                        _auth.changePassword(randomString(10));
                        setState(() => error = "Account locked, please reset password");
                      } else {
                        try {
                          passwordMap[_email] ++;
                        } catch(e) {
                          passwordMap[_email] = 1;
                        }
                      }
                    } else if (result == "PlatformException(ERROR_TOO_MANY_REQUESTS, We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts. Please try again later. ], null)") {
                      HapticFeedback.vibrate();
                      setState(() => error = "Too many requests, Please try again later");
                    }

                    else {
                      Fluttertoast.showToast(
                        msg: "Successfully logged in",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 2,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16,
                      );
                    }
                  } else {
                    HapticFeedback.vibrate();
                  }
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink[400],
                onPressed: () {
                  resetPasswordLinkAlert(context);
                },
                child: Text(
                  "Forgotten your password?",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text("base67480@gmail.com"),
                color: Colors.red[300],
                onPressed: () async {
                  dynamic result = await _auth.signInWithEmailAndPassword('base67480@gmail.com', 'Pa55word!');
                  Fluttertoast.showToast(
                    msg: "Successfully logged in",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 2,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16,
                  );
                },
              ),
              SizedBox(height: 12,)
            ],
          ),
        ),
      ),
    );
  }
}




















