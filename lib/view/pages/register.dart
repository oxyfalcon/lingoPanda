import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingolearn/model/api/api_service.dart';
import 'package:pingolearn/model/api_status_model.dart';
import 'package:pingolearn/utils/extension.dart';
import 'package:pingolearn/utils/validator.dart';
import 'package:pingolearn/view/pages/new_screen.dart';
import 'package:pingolearn/view/viewUtils/app_button.dart';
import 'package:pingolearn/view/viewUtils/customForm/custom_form_widget.dart';
import 'package:pingolearn/view/viewUtils/customForm/custom_text_field.dart';
import 'package:pingolearn/view/viewUtils/news_app_bar.dart';
import 'package:pingolearn/viewModel/future_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailIdController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  final GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();

  @override
  void initState() {
    super.initState();
    emailIdController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailIdController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureProvider<void>(futureCallback: () async {
      await ApiService.createUser(
          email: emailIdController.text, password: passwordController.text);
      await ApiService.add(
          name: nameController.text, emailId: emailIdController.text);
    }, builder: (context, child) {
      return Scaffold(
        appBar: const NewsAppBar(),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: CustomForm(
            formKey: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: CustomTextFormField(
                            hintText: "Name",
                            controller: nameController,
                            validator: Validator.nameValidator,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: CustomTextFormField(
                            controller: emailIdController,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              UpperCaseFormatter()
                            ],
                            validator: Validator.validEmail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: CustomTextFormField(
                            controller: passwordController,
                            passwordObsureIcon: true,
                            hintText: "Password",
                            validator: Validator.passwordValidator,
                          ),
                        ),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          passwordObsureIcon: true,
                          hintText: "Confirm Password",
                          validator: (value) {
                            if (Validator.passwordValidator(
                                    passwordController.text) ==
                                null) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password";
                              } else if (value != passwordController.text) {
                                return "Confirm password does not match";
                              } else {
                                return null;
                              }
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppButton(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context
                                .read<CustomFutureNotifier<void>>()
                                .callFuture(
                                    successMessage: "New user created",
                                    errorMessage: (error, stackTrace) {
                                      if (error is FirebaseAuthException) {
                                        return error.code
                                            .replaceAll("-", " ")
                                            .toUpperCase();
                                      } else if (error is FirebaseException) {
                                        return error.message;
                                      }
                                      return null;
                                    });
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NewScreen()),
                                  (route) => false);
                            }
                          }
                        }, child: Consumer<CustomFutureNotifier<void>>(
                            builder: (context, ref, child) {
                          if (ref.asyncValue.status == ApiStatusEnum.loading) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ));
                          } else {
                            return Text(
                              "Signup",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            );
                          }
                        })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: RichText(
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                children: [
                              TextSpan(
                                  text: "Already have an account? ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              TextSpan(
                                  text: "Login",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                            ])),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
