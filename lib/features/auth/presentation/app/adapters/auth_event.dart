part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});
  final String email;
  final String password;
  final String firstName;
  final String lastName;
}
