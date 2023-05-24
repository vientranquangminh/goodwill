// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/basic_model.dart';

class PurchaseHistoryModel extends BasicModel {
  String? productId;
  int? quantity;
  DateTime? createdAt;
  String? transactionId;

  PurchaseHistoryModel({
    String? id,
    this.productId,
    this.quantity,
    this.createdAt,
    this.transactionId,
  }) : super(id: id);

  PurchaseHistoryModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    DateTime? createdAt,
    String? transactionId,
  }) {
    return PurchaseHistoryModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'transactionId': transactionId,
    };
  }

  factory PurchaseHistoryModel.fromMap(Map<String, dynamic> map) {
    return PurchaseHistoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      transactionId:
          map['transactionId'] != null ? map['transactionId'] as String : null,
    );
  }

  factory PurchaseHistoryModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return PurchaseHistoryModel.fromMap(dataMap ?? {});
  }

  @override
  String toJson() => json.encode(toMap());

  factory PurchaseHistoryModel.fromJson(String source) =>
      PurchaseHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurchaseHistoryModel(id: $id, productId: $productId, quantity: $quantity, createdAt: $createdAt, transactionId: $transactionId)';
  }

  @override
  bool operator ==(covariant PurchaseHistoryModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.quantity == quantity &&
        other.createdAt == createdAt &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        createdAt.hashCode ^
        transactionId.hashCode;
  }

  static PurchaseHistoryModel get sample {
    return PurchaseHistoryModel(
        productId: '2TAI1Xh3FPQvfIaIbclq',
        quantity: 2,
        createdAt: DateTime.now(),
        transactionId: 'xxx33xxxx44');
  }
}
