// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/basic_model.dart';

class CartItemModel extends BasicModel {
  String? productId;
  int? quantity;
  DateTime? createdAt;

  CartItemModel({
    String? id,
    this.productId,
    this.quantity,
    this.createdAt,
  }) : super(id: id);

  CartItemModel copyWith({
    String? productId,
    int? quantity,
    DateTime? createdAt,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (productId != null) 'productId': productId,
      if (quantity != null) 'quantity': quantity,
      if (createdAt != null) 'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] != null ? map['id'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CartItemModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return CartItemModel.fromMap(dataMap ?? {});
  }

  @override
  String toString() =>
      'CartItemModel(id: $id, productId: $productId, quantity: $quantity, createdAt: $createdAt)';

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.quantity == quantity &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      productId.hashCode ^ quantity.hashCode ^ createdAt.hashCode;
}
