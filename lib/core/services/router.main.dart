part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

_transitionsBuilder(
    {required Animation<double> animation,
    required Widget child,
    String? type = 'fade'}) {
  switch (type) {
    case 'fade':
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    default:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
  }
}

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => LoginScreen.path,
    ),
    GoRoute(
      path: LoginScreen.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
            create: (_) => sl<AuthBloc>(), child: const LoginScreen()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _transitionsBuilder(animation: animation, child: child),
      ),
    ),
    GoRoute(
      path: RegisterScreen.path,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
            create: (_) => sl<AuthBloc>(), child: const RegisterScreen()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _transitionsBuilder(animation: animation, child: child),
      ),
    )
  ],
);
