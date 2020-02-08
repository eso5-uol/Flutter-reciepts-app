import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../validators.dart';
import '../../validators.dart';
import '../services/auth.dart';
import 'change_password_popup.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              showDialog(context: context, builder: (_) {
                return ChangePasswordPopup();
              });
            },
            child: Text("Change your password"),
          ),
        ],
      ),

    );
  }
}
