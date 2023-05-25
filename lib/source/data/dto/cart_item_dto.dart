// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItemDto {
  String id;
  String title;
  String? location;
  int price;
  int quantity;
  String sellerId;
  String productId;
  String? phoneNumber;
  String? category;
  String imageUrl;

  CartItemDto({
    required this.id,
    required this.title,
    this.location,
    required this.price,
    required this.quantity,
    required this.sellerId,
    required this.productId,
    this.phoneNumber,
    this.category,
    required this.imageUrl,
  });

  CartItemDto copyWith({
    String? id,
    String? title,
    String? location,
    int? price,
    int? quantity,
    String? sellerId,
    String? productId,
    String? phoneNumber,
    String? category,
    String? imageUrl,
  }) {
    return CartItemDto(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sellerId: sellerId ?? this.sellerId,
      productId: productId ?? this.productId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'location': location,
      'price': price,
      'quantity': quantity,
      'sellerId': sellerId,
      'productId': productId,
      'phoneNumber': phoneNumber,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  factory CartItemDto.fromMap(Map<String, dynamic> map) {
    return CartItemDto(
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      sellerId: map['sellerId'] as String,
      productId: map['productId'] as String,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemDto.fromJson(String source) =>
      CartItemDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemDto(id: $id, title: $title, location: $location, price: $price, quantity: $quantity, sellerId: $sellerId, productId: $productId, phoneNumber: $phoneNumber, category: $category, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant CartItemDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.location == location &&
        other.price == price &&
        other.quantity == quantity &&
        other.sellerId == sellerId &&
        other.productId == productId &&
        other.phoneNumber == phoneNumber &&
        other.category == category &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        location.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        sellerId.hashCode ^
        productId.hashCode ^
        phoneNumber.hashCode ^
        category.hashCode ^
        imageUrl.hashCode;
  }
}
