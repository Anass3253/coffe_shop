import 'package:flutter/material.dart';

class CustomTxtField extends StatelessWidget {
  const CustomTxtField({
    super.key,
    required this.txtHint,
    required this.txtController,
    required this.keyboardType,
    required this.isPass,
    required this.validator,
  });
  final String txtHint;
  final TextEditingController txtController;
  final TextInputType keyboardType;
  final bool isPass;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isPass,
      keyboardType: keyboardType,
      controller: txtController,
      decoration: InputDecoration(
        label: Text(txtHint),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
