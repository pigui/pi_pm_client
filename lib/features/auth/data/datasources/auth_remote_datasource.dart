import 'package:dio/dio.dart';
import 'package:pi_pm_client/core/common/app/singletons/user_logged.dart';
import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/core/common/singletons/network.dart';
import 'package:pi_pm_client/core/errors/exceptions.dart';
import 'package:pi_pm_client/features/auth/data/mappers/user_mapper.dart';
import 'package:pi_pm_client/features/auth/data/models/user_model.dart';
import 'dart:convert' as convert;

abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
}

const _authPath = '/auth';
const _loginEndpoint = '$_authPath/login-with-password';
const _registerEndpoint = '$_authPath/register-with-password';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(
      this.http, this.newtWork, this.logged, this._userMapper);
  final Dio http;
  final Network newtWork;
  final UserLogged logged;
  final UserMapper _userMapper;

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await http.post('${newtWork.apiUrl}$_loginEndpoint',
          data: convert.jsonEncode({"email": email, "password": password}),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ));
      if (response.data == null) {
        final int statusCode = response.statusCode ?? 500;
        throw ServerException(message: 'no data', statusCode: statusCode);
      }
      final userResponse = response.data['user'];
      final UserModel userModel = UserModel.fromMap(userResponse);
      final user = _userMapper.toDomain(userModel);
      logged.setUser(user);
      logged.setAccessToken(response.data['accessToken']);
      logged.setRefreshToken(response.data['refreshToken']);
      return user;
    } on ServerException {
      rethrow;
    } catch (e) {
      if (e is DioException) {
        final String message =
            e.response?.data['message'] ?? e.message ?? 'Dio error';
        throw ServerException(
            message: message, statusCode: e.response?.statusCode ?? 500);
      }
      throw const ServerException(message: 'error', statusCode: 500);
    }
  }

  @override
  Future<User> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      final response = await http.post('${newtWork.apiUrl}$_registerEndpoint',
          data: convert.jsonEncode({
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName
          }),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ));
      if (response.data == null) {
        final int statusCode = response.statusCode ?? 500;
        throw ServerException(message: 'no data', statusCode: statusCode);
      }
      final userResponse = response.data['user'];
      final UserModel userModel = UserModel.fromMap(userResponse);
      final user = _userMapper.toDomain(userModel);
      logged.setUser(user);
      logged.setAccessToken(response.data['accessToken']);
      logged.setRefreshToken(response.data['refreshToken']);
      return user;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(message: 'error', statusCode: 500);
    }
  }
}
