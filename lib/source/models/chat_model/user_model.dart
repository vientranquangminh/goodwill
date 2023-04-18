class User {
  final int id;
  final String name;
  final String? avatar;

  User({
    required this.id,
    required this.name,
     this.avatar,
  });
}

final User currentUser =
    User(id: 0, name: 'You', avatar: 'assets/images/Addison.jpg');

final User drake =
    User(id: 1, name: 'Dr. Drake Boeson', avatar: 'assets/images/Addison.jpg');

final User aidan =
    User(id: 2, name: 'Dr. Adian Allende', avatar: 'assets/images/Angel.jpg');

final User salvatore =
    User(id: 3, name: 'Dr. Salvatore Heredia', avatar: 'assets/images/Deanna.jpg');

final User delaney = User(id: 4, name: 'Dr. Delaney Magino', avatar: 'assets/images/Jason.jpg');

final User beckett = User(id: 5, name: 'Dr. Beckett Calget', avatar: 'assets/images/Judd.jpg');

final User berrnard =
    User(id: 6, name: 'Dr. Bernard Bliss', avatar: 'assets/images/Leslie.jpg');

final User jada =
    User(id: 7, name: 'Dr. Jada Srnsky', avatar: 'assets/images/Nathan.jpg');

final User randy =
    User(id: 8, name: 'Dr. Randy Wigham', avatar: 'assets/images/Stanley.jpg');


