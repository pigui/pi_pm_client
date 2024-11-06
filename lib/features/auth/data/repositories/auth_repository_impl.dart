import 'package:dartz/dartz.dart';
import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/core/errors/exceptions.dart';
import 'package:pi_pm_client/core/errors/failures.dart';
import 'package:pi_pm_client/core/utils/typedefs.dart';
import 'package:pi_pm_client/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pi_pm_client/features/auth/data/mappers/user_mapper.dart';
import 'package:pi_pm_client/features/auth/data/models/user_model.dart';
import 'package:pi_pm_client/features/auth/domain/repositories/auth_respository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._userMapper);
  final AuthRemoteDataSource _remoteDataSource;
  final UserMapper _userMapper;
  @override
  ResultFuture<User> login(
      {required String email, required String password}) async {
    try {
      final UserModel userModel =
          await _remoteDataSource.login(email: email, password: password);

      return Right(_userMapper.toDomain(userModel));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      final UserModel userModel = await _remoteDataSource.register(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName);
      return Right(_userMapper.toDomain(userModel));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
