import 'package:flutter/material.dart';
import 'package:pingolearn/view/viewUtils/custom_shape.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onPressed, required this.child});
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 240,
      child: FilledButton(
        onPressed: onPressed,
        style: const ButtonStyle(shape: CustomShape(radius: 8)),
        child: child,
      ),
    );
  }
}
