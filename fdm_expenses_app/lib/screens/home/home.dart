import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/form/expenseForm.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            // Firestore has a document in the 'users' collection with the current user's UID
            return checkRole(snapshot.data, context);
          }
          return LinearProgressIndicator();
        });
  }

  Container checkRole(DocumentSnapshot snapshot, context) {
    if (snapshot.data == null) {
      return Container(
          child: Text(
              "No data set in Firestore for the current user - check Firestore!"));
    }
    if (snapshot.data['role'] == 'admin') {
      return adminPage(context);
    } else {
      return userPage(context);
    }
  }

  Container adminPage(context) {
    final user = Provider.of<User>(context);
    return Container(
      child: Column(
        children: <Widget>[
//          Text("Home Screen"),
          RaisedButton(
              child: Text('Register an account'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return ExpenceForm();
                    });
              }),
//          Text(user.uid)
        ],
      ),
    );
  }

  Container userPage(context) {
    final user = Provider.of<User>(context);
    return Container(
        child: Column(children: <Widget>[
//          Text("Home Screen"),
      Text("User page - user buttons go here"),
//          Text(user.uid)
    ]));
  }
}
