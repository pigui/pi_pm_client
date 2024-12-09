import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pi_pm_client/core/common/app/singletons/user_logged.dart';
import 'package:pi_pm_client/core/services/injection_container.dart';
import 'package:pi_pm_client/features/auth/presentation/views/views.dart';
import 'package:go_router/go_router.dart';
import 'package:pi_pm_client/features/dashboard/presentation/widgets/navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({required this.state, required this.child, super.key});
  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final userLogged = sl<UserLogged>();
    if (userLogged.isLogged == false) {
      context.go(LoginScreen.path);
    }
    return Scaffold(
        body: child,
        bottomNavigationBar: DashboardNavigationBar(
          items: const [],
          onTap: (index) {},
        ));
  }
}
