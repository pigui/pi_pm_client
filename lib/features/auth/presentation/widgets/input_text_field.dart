import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthInputTextField extends StatelessWidget {
  const AuthInputTextField(
      {super.key,
      required this.name,
      required this.validators,
      required this.labelText,
      this.icon,
      this.errorText,
      this.obscureText = false,
      this.onChange,
      this.controller});
  final String name;
  final String? Function(String?)? validators;
  final String labelText;
  final Widget? icon;
  final String? errorText;
  final bool obscureText;
  final void Function(String?)? onChange;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9\s@._-]*$')),
        ],
        controller: controller,
        onChanged: onChange,
        obscureText: obscureText,
        name: name,
        decoration: _inputDecoration(labelText: labelText),
        validator: validators);
  }
}

InputDecoration _inputDecoration(
    {required String labelText, Widget? icon, String? errorText}) {
  return InputDecoration(
    labelText: labelText,
    icon: icon,
    errorText: errorText,
  );
}
