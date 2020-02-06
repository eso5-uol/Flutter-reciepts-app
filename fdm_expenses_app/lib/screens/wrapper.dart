import 'package:fdm_expenses_app/screens/authenticate/authenticate.dart';
import 'package:fdm_expenses_app/screens/home/home.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fdm_expenses_app/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate widget

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
