// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfile {
  String id;
  String? fullName;
  String? nickName;
  DateTime? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;

  UserProfile({
    required this.id,
    this.fullName,
    this.nickName,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'nickName': nickName,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      nickName: map['nickName'] != null ? map['nickName'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int)
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? nickName,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
    String? address,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nickName: nickName ?? this.nickName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  static UserProfile get sample {
    return UserProfile(
        id: 'uniqueId',
        fullName: 'Do Minh Thanh',
        nickName: 'Lil rua',
        dateOfBirth: DateTime.utc(2001),
        gender: 'male',
        phoneNumber: '0x00001002',
        address: 'Da Nang city');
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, fullName: $fullName, nickName: $nickName, dateOfBirth: $dateOfBirth, gender: $gender, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.nickName == nickName &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        nickName.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode;
  }
}
