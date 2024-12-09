import 'package:flutter/material.dart';
import 'package:pi_pm_client/core/common/app/singletons/user_logged.dart';
import 'package:pi_pm_client/core/services/injection_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String path = '/home';

  @override
  Widget build(BuildContext context) {
    final UserLogged userLogged = sl<UserLogged>();
    return SafeArea(child: Text(userLogged.userValue.toString()));
  }
}
