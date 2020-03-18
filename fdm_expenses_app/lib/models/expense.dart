import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Expense{
  final String title;
  final String imageUrl;
  final String uid;
  final String amount;
  final String date;
  final String documentId;

  Expense({
    @required this.uid,
    @required this.title,
    @required this.date,
    this.amount,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toJson(){
    return {
      'userId': uid,
      'title': title,
      'data': date,
      'amount': amount,
      'imageUrl': imageUrl
    };
  }

  static Expense fromJson(Map<String, dynamic>map){
    if (map==null) return null;
    return Expense(
      title: map['title'],
      uid: map['userId'],
      date: map['data'],
      amount: map['amount'],

    );
  }
}