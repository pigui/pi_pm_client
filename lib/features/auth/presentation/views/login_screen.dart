import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pi_pm_client/features/auth/presentation/app/adapters/auth_bloc.dart';
import 'package:pi_pm_client/features/auth/presentation/views/views.dart';
import 'package:pi_pm_client/features/auth/presentation/widgets/button.dart';
import 'package:pi_pm_client/features/auth/presentation/widgets/input_text_field.dart';
import 'package:gap/gap.dart';
import 'package:pi_pm_client/features/home/presentation/views/home_view.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String path = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      context.loaderOverlay.hide();
                      if (state is AuthError) {
                        toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          title: Text(state.message),
                          style: ToastificationStyle.minimal,
                          type: ToastificationType.error,
                          autoCloseDuration: const Duration(seconds: 5),
                        );
                      }
                      if (state is AuthLoading) {
                        context.loaderOverlay.show();
                      }
                      if (state is AuthLogin) {
                        context.go(HomeView.path);
                      }
                    },
                    builder: (context, state) => FormBuilder(
                          key: _formKey,
                          child: SafeArea(
                            child: Column(
                              children: [
                                const Gap(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: AuthInputTextField(
                                      controller: emailController,
                                      name: 'email',
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.email(),
                                      ]),
                                      labelText: translate('auth.login.email')),
                                ),
                                const Gap(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: AuthInputTextField(
                                      obscureText: true,
                                      controller: passwordController,
                                      name: 'password',
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      labelText:
                                          translate('auth.login.password')),
                                ),
                                const Gap(20),
                                SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: AuthButton(
                                          onPressed: state is AuthLoading
                                              ? null
                                              : () {
                                                  final bool? validate =
                                                      _formKey.currentState
                                                          ?.validate();

                                                  if (validate == true) {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(LoginEvent(
                                                            email:
                                                                emailController
                                                                    .text
                                                                    .trim(),
                                                            password:
                                                                passwordController
                                                                    .text
                                                                    .trim()));
                                                  }
                                                },
                                          child: Center(
                                            child: Text(translate(
                                                'auth.login.button.login')),
                                          )),
                                    )),
                                const Gap(20),
                                SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: AuthButton(
                                          onPressed: state is AuthLoading
                                              ? null
                                              : () {
                                                  context
                                                      .go(RegisterScreen.path);
                                                },
                                          child: Center(
                                            child: Text(translate(
                                                'auth.login.button.register')),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        )))));
  }
}
