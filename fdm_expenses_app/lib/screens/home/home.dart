import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:fdm_expenses_app/screens/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

//    return Container(
//      child: Column(
//        children: <Widget>[
//          Text("Home Screen"),
//          RaisedButton(
//              child: Text('Register an account'),
//              onPressed: () {
//                showDialog(context: context, builder: (_) {
//                  return Register();
//                });
//              }),
//        ],
//      ),
//
//    );

    return StreamBuilder<DocumentSnapshot>(
        stream: databaseReference
            .collection("users")
            .document(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Text('Firestore has a document for the current UID');
              }
              return LinearProgressIndicator();
            }
          );
        }

  }

