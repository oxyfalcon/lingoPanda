import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/model/api_status_model.dart';
import 'package:pingolearn/view/pages/new_screen.dart';
import 'package:pingolearn/view/viewUtils/app_button.dart';
import 'package:pingolearn/view/viewUtils/customForm/custom_form_widget.dart';
import 'package:pingolearn/viewModel/future_provider.dart';
import 'package:provider/provider.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key, required this.formKey});

  final GlobalKey<CustomFormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: AppButton(onPressed: () async {
        if (formKey.currentState!.validate()) {
          await context.read<CustomFutureNotifier<void>>().callFuture(
              successMessage: "New user created",
              errorMessage: (error, stackTrace) {
                if (error is FirebaseAuthException) {
                  return error.code.replaceAll("-", " ").toUpperCase();
                } else if (error is FirebaseException) {
                  return error.message;
                }
                return null;
              });
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const NewScreen()),
                (route) => false);
          }
        }
      }, child:
          Consumer<CustomFutureNotifier<void>>(builder: (context, ref, child) {
        if (ref.asyncValue.status == ApiStatusEnum.loading) {
          return const Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ));
        } else {
          return Text(
            "Signup",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimary),
          );
        }
      })),
    );
  }
}
