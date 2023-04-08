class PostModel {
  String image;
  String name;
  int price;
  String time;
  String location;
  PostModel(
      {required this.image,
      required this.name,
      required this.price,
      required this.time,
      required this.location});
}

List<PostModel> listPostModel = [
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "24h ago",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "2h ago",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "3h ago",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "4h ago",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "Now",
      location: "Da Nang"),
  PostModel(
      image: "assets/images/home_page/item.png",
      name: 'Nike Air Force 1',
      price: 200,
      time: "24h ago",
      location: "Da Nang"),
];
