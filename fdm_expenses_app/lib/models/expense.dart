import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Expense{
  final String category;
  final String imageUrl;
  final String uid;
  final String amount;
  final String date;
  final String currency;
  final String description;
  final String documentId;

  Expense({
    @required this.uid,
    @required this.amount,
    @required this.category,
    @required this.date,
    @required this.currency,
    @required this.description,
    this.documentId,
    this.imageUrl,
  });

  Map<String, dynamic> toJson(){
    return {
      'userId': uid,
      'category': category,
      'data': date,
      'amount': amount,
      'currency': currency,
      'imageUrl': imageUrl,
      'description': description
    };
  }

  static Expense fromJson(Map<String, dynamic>map){
    if (map==null) return null;
    return Expense(
      category: map['category'],
      uid: map['userId'],
      date: map['date'],
      amount: map['amount'],
      currency: map['currency'],
      description: map['description']
    );
  }
}