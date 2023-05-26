// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:goodwill/source/data/model/basic_model.dart';
import 'package:goodwill/source/enum/category_enum.dart';
import 'package:goodwill/source/service/auth_service.dart';

class ProductModel extends BasicModel {
  String? ownerId;
  String? title;
  String? description;
  String? category;
  String? status;
  int? price;
  int quantity;
  DateTime? createdAt;
  List<String>? images;
  String? location;

  ProductModel({
    String? id,
    this.ownerId,
    this.title,
    this.description,
    this.category,
    this.price,
    this.createdAt,
    this.images,
    required this.quantity,
    this.location,
    this.status,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (ownerId != null) 'ownerId': ownerId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (status != null) 'status': status,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (createdAt != null) 'createdAt': createdAt?.millisecondsSinceEpoch,
      if (images != null) 'images': images,
      if (location != null) 'location': location,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : 1,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      images: map['images'] != null ? List.from(map['images']) : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ProductModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return ProductModel.fromMap(dataMap ?? {});
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, ownerId: $ownerId, title: $title, description: $description, category: $category, status: $status, price: $price, quantity: $quantity, createdAt: $createdAt, images: $images, location: $location)';
  }

  ProductModel copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? description,
    String? category,
    String? status,
    int? price,
    required int quantity,
    DateTime? createdAt,
    List<String>? images,
    String? location,
  }) {
    return ProductModel(
      id: this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      quantity: quantity,
      images: images ?? this.images,
      location: location ?? this.location,
    );
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ownerId == ownerId &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.status == status &&
        other.price == price &&
        other.quantity == quantity &&
        other.createdAt == createdAt &&
        listEquals(other.images, images) &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ownerId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        status.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        createdAt.hashCode ^
        images.hashCode ^
        location.hashCode;
  }

  static ProductModel get sample {
    return ProductModel(
      title: "Stupid thing",
      ownerId: AuthService.userId,
      description: "an iPhone",
      price: 20000,
      quantity: 1,
      createdAt: DateTime.now(),
      location: 'Da Nang',
      status: OwnProductStatus.OVERDATE,
      category: CategoryEnum.CLOTHES,
    );
  }

  static List<ProductModel> get sampleProductModels {
    return [
      ProductModel(
          images: [
            "https://firebasestorage.googleapis.com/v0/b/goodwill-83933.appspot.com/o/images%2Fproducts%2Fitem.png?alt=media&token=a84bb3a0-a38b-4156-8d7d-bd9e2e6d5ec5"
          ],
          title: 'Nike Air Force 1',
          price: 200,
          quantity: 1,
          createdAt: DateTime.now(),
          category: CategoryEnum.CLOTHES,
          location: "Da Nang"),
      ProductModel(
          images: [
            "https://firebasestorage.googleapis.com/v0/b/goodwill-83933.appspot.com/o/images%2Fproducts%2Fitem.png?alt=media&token=a84bb3a0-a38b-4156-8d7d-bd9e2e6d5ec5"
          ],
          title: 'Nike Air Force 1',
          price: 200,
          quantity: 1,
          createdAt: DateTime.now(),
          category: CategoryEnum.TOYS,
          location: "Da Nang"),
      ProductModel(
          images: [
            "https://firebasestorage.googleapis.com/v0/b/goodwill-83933.appspot.com/o/images%2Fproducts%2Fitem.png?alt=media&token=a84bb3a0-a38b-4156-8d7d-bd9e2e6d5ec5"
          ],
          title: 'Nike Air Force 1',
          price: 200,
          quantity: 1,
          createdAt: DateTime.now(),
          category: CategoryEnum.KITCHEN,
          location: "Da Nang"),
      ProductModel(
          images: [
            "https://firebasestorage.googleapis.com/v0/b/goodwill-83933.appspot.com/o/images%2Fproducts%2Fitem.png?alt=media&token=a84bb3a0-a38b-4156-8d7d-bd9e2e6d5ec5"
          ],
          title: 'Nike Air Force 1',
          price: 200,
          quantity: 1,
          createdAt: DateTime.now(),
          category: CategoryEnum.SHOES,
          location: "Da Nang"),
      ProductModel(
          images: [
            "https://firebasestorage.googleapis.com/v0/b/goodwill-83933.appspot.com/o/images%2Fproducts%2Fitem.png?alt=media&token=a84bb3a0-a38b-4156-8d7d-bd9e2e6d5ec5"
          ],
          title: 'Nike Air Force 1',
          price: 200,
          quantity: 1,
          createdAt: DateTime.now(),
          category: CategoryEnum.BAGS,
          location: "Da Nang"),
    ];
  }
}

class OwnProductStatus {
  static const String SHOWING = 'showing';
  static const String OVERDATE = 'overdate';
  static const String DENIED = 'denied';
}
