import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? suffixIconData;
  final VoidCallback? onPressedIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enable;

  const TextFieldLogin({
    Key? key,
    this.controller,
    this.labelText = '',
    this.suffixIconData,
    this.onPressedIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIconData != null
              ? IconButton(
                  icon: Icon(suffixIconData),
                  onPressed: onPressedIcon,
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enable,
      ),
    );
  }
}
