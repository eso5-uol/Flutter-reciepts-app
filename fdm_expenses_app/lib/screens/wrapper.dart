import 'package:fdm_expenses_app/screens/authenticate/authenticate.dart';
import 'package:fdm_expenses_app/screens/home/home.dart';
import 'package:fdm_expenses_app/screens/home/logged_in.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fdm_expenses_app/models/user.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate widget

    if (user == null) {
      return Authenticate();
    } else {
      return LoggedIn();
    }
  }
}
