import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.createdAt,
      required this.updatedAt});

  User.empty()
      : id = '',
        email = '',
        firstName = '',
        lastName = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;
  @override
  List<Object?> get props =>
      [id, email, firstName, lastName, createdAt, updatedAt];
}
