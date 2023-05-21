// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:goodwill/gen/assets.gen.dart';

class Category {
  String icon;
  String title;
  double rating;
  int quantity;
  String path;
  Category(
      {required this.icon,
      required this.title,
      this.quantity = 0,
      this.rating = 0.0,
      required this.path});

  Category copyWith(
      {String? icon,
      String? title,
      double? rating,
      int? quantity,
      String? path}) {
    return Category(
        icon: icon ?? this.icon,
        title: title ?? this.title,
        path: path ?? this.path,
        rating: rating ?? this.rating,
        quantity: quantity ?? this.quantity);
  }

  @override
  String toString() {
    return 'Category(icon: $icon, title: $title, rating: $rating, quantity: $quantity, path: $path)';
  }
}

List<Category> listCategories = [
  Category(
      icon: 'assets/svgs/casual_t_shirt.svg',
      title: 'Clothes',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/sport-shoe.svg',
      title: 'Shoes',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/bag.svg',
      title: 'Bags',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/electronic_devices.svg',
      title: 'Electronic',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/hand-watch.svg',
      title: 'Watch',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/necklace.svg',
      title: 'Jewelry',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/cooking.svg',
      title: 'Kitchen',
      path: Assets.images.homePage.item.path),
  Category(
      icon: 'assets/svgs/sister_and_brother.svg',
      title: 'Toys',
      path: Assets.images.homePage.item.path),
];
