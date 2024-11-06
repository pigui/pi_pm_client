import 'dart:convert';

import 'package:pi_pm_client/core/utils/typedefs.dart';

class UserModel {
  const UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.createdAt,
      required this.updatedAt});
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    final createdAt = DateTime.parse(map['createdAt'] as String);
    final updatedAt = DateTime.parse(map['updatedAt'] as String);
    return UserModel(
        id: map['id'] as String? ?? map['id'] as String,
        email: map['email'] as String? ?? map['email'] as String,
        firstName: map['firstName'] as String? ?? map['firstName'] as String,
        lastName: map['lastName'] as String? ?? map['lasttName'] as String,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }
}
