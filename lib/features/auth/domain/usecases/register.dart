import 'package:equatable/equatable.dart';
import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/core/usecase/usercase.dart';
import 'package:pi_pm_client/core/utils/typedefs.dart';
import 'package:pi_pm_client/features/auth/domain/repositories/auth_respository.dart';

class Register implements UsecaseWithParams<User, RegisterParams> {
  const Register(this.authRepository);

  final AuthRepository authRepository;

  @override
  ResultFuture<User> call(RegisterParams params) => authRepository.register(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName);
}

class RegisterParams extends Equatable {
  const RegisterParams(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
