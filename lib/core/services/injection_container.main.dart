part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initEnv();
  await _initCommon();
  await _initHttp();
  await _initAuth();
}

Future<void> _initEnv() async {
  sl.registerLazySingleton(
      () => const Environment('http://localhost:3000', true));
}

Future<void> _initCommon() async {
  sl
    ..registerLazySingleton(() => Network(sl()))
    ..registerLazySingleton(() => UserLogged());
}

Future<void> _initHttp() async {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    responseHeader: true,
    responseBody: true,
  ));

  sl.registerLazySingleton(() => dio);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(login: sl(), register: sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl(), sl(), sl(), sl()))
    ..registerLazySingleton<UserMapper>(() => UserMapper())
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton(() => Login((sl())))
    ..registerLazySingleton(() => Register(sl()));
}
