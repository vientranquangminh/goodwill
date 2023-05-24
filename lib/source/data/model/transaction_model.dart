// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:goodwill/source/data/model/basic_model.dart';

class TransactionModel extends BasicModel {
  // String? id;
  String? senderId;
  String? zpTransToken;
  int? amount;
  List<Map<String, dynamic>>? items;

  TransactionModel({
    String? id,
    this.senderId,
    this.zpTransToken,
    this.amount,
    required this.items,
  }) : super(id: id);

  TransactionModel copyWith({
    String? senderId,
    String? zpTransToken,
    int? amount,
    List<Map<String, dynamic>>? items,
  }) {
    return TransactionModel(
      senderId: senderId ?? this.senderId,
      zpTransToken: zpTransToken ?? this.zpTransToken,
      amount: amount ?? this.amount,
      items: items ?? this.items,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'zpTransToken': zpTransToken,
      'amount': amount,
      'items': items,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      zpTransToken:
          map['zpTransToken'] != null ? map['zpTransToken'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      items: map['items'] != null
          ? List<Map<String, dynamic>>.from(map['items'])
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return TransactionModel.fromMap(dataMap ?? {});
  }

  @override
  String toString() {
    return 'TransactionModel(senderId: $senderId, zpTransToken: $zpTransToken, amount: $amount, items: $items)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.zpTransToken == zpTransToken &&
        other.amount == amount &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        zpTransToken.hashCode ^
        amount.hashCode ^
        items.hashCode;
  }
}
