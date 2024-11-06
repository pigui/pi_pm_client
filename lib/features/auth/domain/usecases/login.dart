import 'package:equatable/equatable.dart';
import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/core/usecase/usercase.dart';
import 'package:pi_pm_client/core/utils/typedefs.dart';
import 'package:pi_pm_client/features/auth/domain/repositories/auth_respository.dart';

class Login implements UsecaseWithParams<User, LoginParams> {
  const Login(this.authRepository);
  final AuthRepository authRepository;
  @override
  ResultFuture<User> call(LoginParams params) =>
      authRepository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
