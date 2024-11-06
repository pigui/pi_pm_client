import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pi_pm_client/core/common/entities/user.dart';
import 'package:pi_pm_client/features/auth/domain/usecases/login.dart';
import 'package:pi_pm_client/features/auth/domain/usecases/register.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.login, required this.register})
      : super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on(_loginHandler);
    on(_registerHandler);
  }
  final Login login;
  final Register register;

  Future<void> _loginHandler(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final LoginParams params =
        LoginParams(email: event.email, password: event.password);
    final result = await login(params);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthLogin(user)),
    );
  }

  Future<void> _registerHandler(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    final RegisterParams params = RegisterParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName);

    final result = await register(params);
    result.fold((failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthRegister(user)));
  }
}
