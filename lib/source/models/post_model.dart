class PostModel {
  String image;
  String name;
  int price;
  String time;
  String category;
  String location;
  PostModel(
      {required this.image,
      required this.name,
      required this.price,
      required this.time,
      required this.category,
      required this.location});
}

List<PostModel> listPostModel = [
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "24h ago",
      category: "Clothes",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "2h ago",
      category: "Toys",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "3h ago",
      category: "Toys",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "4h ago",
      category: "Kitchen",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "Now",
      category: "Shoes",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "24h ago",
      category: "Bags",
      location: "Da Nang"),
];
