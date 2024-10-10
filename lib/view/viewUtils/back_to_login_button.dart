import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: RichText(
          text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              children: [
            TextSpan(
                text: "Already have an account? ",
                style: Theme.of(context).textTheme.titleMedium),
            TextSpan(
                text: "Login",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pop(context),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary))
          ])),
    );
  }
}
