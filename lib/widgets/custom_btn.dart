import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.btnLabel,
    required this.onPressed,
  });
  final String btnLabel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        btnLabel,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
