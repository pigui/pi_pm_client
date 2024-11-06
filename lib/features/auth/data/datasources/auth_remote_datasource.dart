import 'package:dio/dio.dart';
import 'package:pi_pm_client/core/common/singletons/network.dart';
import 'package:pi_pm_client/core/errors/exceptions.dart';
import 'package:pi_pm_client/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
}

const _authPath = '/auth';
const _loginEndpoint = '$_authPath/login';
const _registerEndpoint = '$_authPath/register';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this.http, this.newtWork);
  final Dio http;
  final Network newtWork;

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post('${newtWork.apiUrl}$_loginEndpoint');
      if (response.data == null) {
        final int statusCode = response.statusCode ?? 500;
        throw ServerException(message: 'no data', statusCode: statusCode);
      }
      final UserModel userModel = UserModel.fromMap(response.data);
      return userModel;
    } on ServerException {
      rethrow;
    } catch (e) {
      if (e is DioException) {
        final String message = e.message ?? 'Dio error';
        throw ServerException(message: message, statusCode: 500);
      }
      throw const ServerException(message: 'error', statusCode: 500);
    }
  }

  @override
  Future<UserModel> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      final response = await http.post('${newtWork.apiUrl}$_registerEndpoint');
      if (response.data == null) {
        final int statusCode = response.statusCode ?? 500;
        throw ServerException(message: 'no data', statusCode: statusCode);
      }
      final UserModel userModel = UserModel.fromMap(response.data);
      return userModel;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(message: 'error', statusCode: 500);
    }
  }
}
