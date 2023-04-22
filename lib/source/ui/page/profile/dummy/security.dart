class SecurityModel {
  String title;
  bool status;
  SecurityModel({required this.title, required this.status});
}

List<SecurityModel> listSecurity = [
  SecurityModel(title: 'Remember me', status: true),
  SecurityModel(title: 'Face ID', status: false),
  SecurityModel(title: 'Biometric ID', status: false),
];
