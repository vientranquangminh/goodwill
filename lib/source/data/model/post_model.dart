// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:goodwill/source/data/model/basic_model.dart';
import 'package:goodwill/source/service/auth_service.dart';

class PostModel extends BasicModel {
  String? ownerId;
  String? title;
  String? description;
  String? category;
  int? price;
  DateTime? createdAt;
  List<String>? images;
  String? location;

  PostModel({
    String? id,
    this.ownerId,
    this.title,
    this.description,
    this.category,
    this.price,
    this.createdAt,
    this.images,
    this.location,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'images': images,
      'location': location,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      ownerId: map['ownerId'] != null ? map['ownerId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      images: map['images'] != null
          ? List<String>.from(map['images'] as List<String>)
          : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PostModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return PostModel.fromMap(dataMap ?? {});
  }

  @override
  String toString() {
    return 'TestProduct(ownerId: $ownerId, title: $title, description: $description, category: $category, price: $price, createdAt: $createdAt, images: $images, location: $location)';
  }

  PostModel copyWith({
    String? ownerId,
    String? title,
    String? description,
    String? category,
    int? price,
    DateTime? createdAt,
    List<String>? images,
    String? location,
  }) {
    return PostModel(
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      location: location ?? this.location,
    );
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.ownerId == ownerId &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.createdAt == createdAt &&
        listEquals(other.images, images) &&
        other.location == location;
  }

  @override
  int get hashCode {
    return ownerId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        images.hashCode ^
        location.hashCode;
  }

  static PostModel get sample {
    return PostModel(
      title: "iphone",
      ownerId: AuthService.userId,
      description: "an iPhone",
      price: 10000000,
      createdAt: DateTime.now(),
      location: 'Da Nang',
    );
  }

  static List<PostModel> get listPostModel {
    return [
      PostModel(
          images: ["assets/images/home_page/item.png"],
          title: 'Nike Air Force 1',
          price: 200,
          createdAt: DateTime.now(),
          category: "Clothes",
          location: "Da Nang"),
      PostModel(
          images: ["assets/images/home_page/item.png"],
          title: 'Nike Air Force 1',
          price: 200,
          createdAt: DateTime.now(),
          category: "Toys",
          location: "Da Nang"),
      PostModel(
          images: ["assets/images/home_page/item.png"],
          title: 'Nike Air Force 1',
          price: 200,
          createdAt: DateTime.now(),
          category: "Kitchen",
          location: "Da Nang"),
      PostModel(
          images: ["assets/images/home_page/item.png"],
          title: 'Nike Air Force 1',
          price: 200,
          createdAt: DateTime.now(),
          category: "Shoes",
          location: "Da Nang"),
      PostModel(
          images: ["assets/images/home_page/item.png"],
          title: 'Nike Air Force 1',
          price: 200,
          createdAt: DateTime.now(),
          category: "Bags",
          location: "Da Nang"),
    ];
  }
}
