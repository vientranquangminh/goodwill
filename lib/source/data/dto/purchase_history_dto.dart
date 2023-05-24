// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PurchaseHistoryDto {
  String id;
  String title;
  String imageUrl;
  String category;
  String productOwnerName;
  String ownerId;
  int quantity;
  int price;
  DateTime createdAt;
  String transactionId;

  PurchaseHistoryDto({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.productOwnerName,
    required this.ownerId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.transactionId,
  });

  PurchaseHistoryDto copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? category,
    String? productOwnerName,
    String? ownerId,
    int? quantity,
    int? price,
    DateTime? createdAt,
    String? transactionId,
  }) {
    return PurchaseHistoryDto(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      productOwnerName: productOwnerName ?? this.productOwnerName,
      ownerId: ownerId ?? this.ownerId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'productOwnerName': productOwnerName,
      'ownerId': ownerId,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'transactionId': transactionId,
    };
  }

  factory PurchaseHistoryDto.fromMap(Map<String, dynamic> map) {
    return PurchaseHistoryDto(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as String,
      productOwnerName: map['productOwnerName'] as String,
      ownerId: map['ownerId'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      transactionId: map['transactionId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseHistoryDto.fromJson(String source) =>
      PurchaseHistoryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurchaseHistoryDto(id: $id, title: $title, imageUrl: $imageUrl, category: $category, productOwnerName: $productOwnerName, ownerId: $ownerId, quantity: $quantity, price: $price, createdAt: $createdAt, transactionId: $transactionId)';
  }

  @override
  bool operator ==(covariant PurchaseHistoryDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.imageUrl == imageUrl &&
      other.category == category &&
      other.productOwnerName == productOwnerName &&
      other.ownerId == ownerId &&
      other.quantity == quantity &&
      other.price == price &&
      other.createdAt == createdAt &&
      other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      imageUrl.hashCode ^
      category.hashCode ^
      productOwnerName.hashCode ^
      ownerId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      createdAt.hashCode ^
      transactionId.hashCode;
  }
}
