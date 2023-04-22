class Notification {
  String title;
  bool status;
  Notification({required this.title, required this.status});
}

List<Notification> listNotification = [
  Notification(title: 'General Notification', status: true),
  Notification(title: 'Sound', status: false),
  Notification(title: 'Virable', status: false),
  Notification(title: 'Special Offers', status: true),
  Notification(title: 'Promo & Discount', status: true),
  Notification(title: 'Payments', status: true),
  Notification(title: 'Cashback', status: false),
  Notification(title: 'App Updates', status: true),
  Notification(title: 'New Service Available', status: true),
  Notification(title: 'New Tips Available', status: false),
];
