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
  sl.registerLazySingleton(() => Network(sl()));
}

Future<void> _initHttp() async {
  sl.registerLazySingleton(Dio.new);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(login: sl(), register: sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl(), sl()))
    ..registerLazySingleton<UserMapper>(() => UserMapper())
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl(), sl()))
    ..registerLazySingleton(() => Login((sl())))
    ..registerLazySingleton(() => Register(sl()));
}
