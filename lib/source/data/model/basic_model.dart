// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BasicModel {
  String? id;
  BasicModel({
    this.id,
  });

  Map<String, dynamic> toMap();
  String toJson();

  @override
  String toString() => 'BasicModel(id: $id)';

  @override
  bool operator ==(covariant BasicModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
