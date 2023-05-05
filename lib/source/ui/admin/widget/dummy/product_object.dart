class ProductObject {
  String id;
  String title;
  String category;
  String user;
  String createAt;
  String phone;
  int price;
  ProductObject(
      {required this.id,
      required this.title,
      required this.category,
      required this.user,
      required this.createAt,
      required this.phone,
      required this.price});
}

List<ProductObject> listProduct = [
  ProductObject(
      id: 'D01',
      title: 'Iphone',
      category: 'Electronic',
      user: 'thanh',
      createAt: '12/10/2001',
      phone: '0905223344',
      price: 1000),
  ProductObject(
      id: 'D02',
      title: 'Ipad',
      category: 'Electronic',
      user: 'Minh',
      createAt: '02/06/2001',
      phone: '0905223344',
      price: 1000),
];
