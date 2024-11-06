part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLogin extends AuthState {
  const AuthLogin(this.user);
  final User user;
  @override
  List<Object> get props => [user];
}

class AuthRegister extends AuthState {
  const AuthRegister(this.user);
  final User user;
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;

  @override
  List<String> get props => [message];
}
