import 'package:fdm_expenses_app/screens/authenticate/authenticate.dart';
import 'package:fdm_expenses_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return Authenticate();
  }
}
