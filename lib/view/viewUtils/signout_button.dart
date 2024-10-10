import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/model/api_status_model.dart';
import 'package:lingopanda/view/pages/login.dart';
import 'package:lingopanda/viewModel/future_provider.dart';
import 'package:provider/provider.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFutureProvider<void>(
        futureCallback: () => FirebaseAuth.instance.signOut(),
        builder: (context, child) {
          return Consumer<CustomFutureNotifier<void>>(
              builder: (context, ref, child) {
            return (ref.asyncValue.status == ApiStatusEnum.loading)
                ? const CircularProgressIndicator.adaptive()
                : IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await context
                          .read<CustomFutureNotifier<void>>()
                          .callFuture(successMessage: "Logged out");
                      if (context.mounted) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }
                    },
                  );
          });
        });
  }
}
