part of 'router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
  navigatorKey: _rootNavigatorKey,
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
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) => CustomTransitionPage(
              child: DashboardScreen(state: state, child: child),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      _transitionsBuilder(animation: animation, child: child),
            ),
        routes: [
          GoRoute(
            path: HomeView.path,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomeView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      _transitionsBuilder(animation: animation, child: child),
            ),
          )
        ])
  ],
);
