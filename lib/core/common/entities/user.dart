import 'package:equatable/equatable.dart';

class UserStatus extends Equatable {
  const UserStatus({required this.value});
  final String value;

  bool isActive() {
    return value == 'active';
  }

  bool isBlocked() {
    return value == 'blocked';
  }

  @override
  List<Object?> get props => [value];
}

class UserRole extends Equatable {
  const UserRole({required this.value});
  final String value;

  bool isUser() {
    return value == 'user';
  }

  bool isAdmin() {
    return value == 'admin';
  }

  @override
  List<Object?> get props => [value];
}

class User extends Equatable {
  const User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  User.empty()
      : id = '',
        email = '',
        firstName = '',
        lastName = '',
        role = const UserRole(value: 'user'),
        status = const UserStatus(value: 'active'),
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserRole role;
  final UserStatus status;
  @override
  List<Object?> get props =>
      [id, email, firstName, lastName, createdAt, updatedAt];
}
