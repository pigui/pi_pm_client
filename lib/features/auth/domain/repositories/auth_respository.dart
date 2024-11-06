import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/core/utils/typedefs.dart';

abstract class AuthRepository {
  ResultFuture<User> login({required String email, required String password});
  ResultFuture<User> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
}
