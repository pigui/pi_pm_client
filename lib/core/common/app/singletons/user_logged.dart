import 'dart:async';

import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:rxdart/rxdart.dart';

class UserLogged {
  final _accessTokenSubject = BehaviorSubject<String>();
  final _refreshTokenSubject = BehaviorSubject<String>();
  final _userSubject = BehaviorSubject<User>();

  Stream<User> get user => _userSubject.stream;
  Stream<String> get refreshToken => _refreshTokenSubject.stream;
  Stream<String> get accessToken => _accessTokenSubject.stream;

  User get userValue => _userSubject.value;
  String get refreshTokenValue => _refreshTokenSubject.value;
  String get accessTokenValue => _accessTokenSubject.value;

  void setUser(User user) {
    _userSubject.add(user);
  }

  void setAccessToken(String accessToken) {
    _accessTokenSubject.add(accessToken);
  }

  void setRefreshToken(String refreshToken) {
    _refreshTokenSubject.add(refreshToken);
  }
}
