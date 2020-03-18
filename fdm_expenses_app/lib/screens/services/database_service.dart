import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdm_expenses_app/models/expense.dart';
import 'package:flutter/services.dart';

import '../../models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference _userCollectionReference =
  Firestore.instance.collection('users');

  final CollectionReference _expenseCollectionReference =
  Firestore.instance.collection('expenses');

  Future<User> getUser(String uid) async {
    var snap = await _userCollectionReference.document(uid).get();
    return User.fromData(snap.data);
  }

  Stream<User> streamUser(String uid){
    return _userCollectionReference
        .document(uid)
        .snapshots()
        .map((snap) => User.fromData(snap.data));
  }

  //userdata from snapshot

  Expense _userExpenseFromSnapshot(DocumentSnapshot snapshot){
    return Expense(
      uid: uid,
      title: snapshot.data['title'],
      amount: snapshot.data['amount'],
      imageUrl: snapshot.data['imageUrl']
    );
  }

  Future addExpense(Expense expense) async {
    try{
      await _userCollectionReference.document(uid).collection('expenses').add(expense.toJson());
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }

  Stream<Expense> get userExpense{
    return _userCollectionReference.document(uid).snapshots().map(_userExpenseFromSnapshot);
  }

  List<Expense> _expenseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Expense(
        title: doc.data['title'] ?? '',
        amount: doc.data['amount'] ?? 0,
        imageUrl: doc.data['imageUrl'] ?? '',
      );
    }).toList();
  }

  Stream<List<Expense>> get expense{
    return _expenseCollectionReference.snapshots().map(_expenseListFromSnapshot);
  }

}