class UserObject {
  String id;
  String name;
  String nickname;
  String email;
  String dayOfBirth;
  String phone;
  String gender;
  UserObject(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.email,
      required this.dayOfBirth,
      required this.phone,
      required this.gender});
}

List<UserObject> listUser = [
  UserObject(
      id: 'P01',
      name: 'Hoài Linh',
      nickname: 'Linh xe ôm',
      email: 'linhxeom123@gmail.com',
      dayOfBirth: '12/10/2001',
      phone: '0905223344',
      gender: 'Male'),
  UserObject(
      id: 'P02',
      name: 'Đỗ Minh Thành',
      nickname: 'Lil Rùa',
      email: 'dominhthanh0206@gmail.com',
      dayOfBirth: '02/06/2001',
      phone: '0905223344',
      gender: 'Female'),
];
