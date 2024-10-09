import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingolearn/model/api/api_service.dart';
import 'package:pingolearn/model/api_status_model.dart';
import 'package:pingolearn/utils/config.dart';
import 'package:pingolearn/utils/extension.dart';
import 'package:pingolearn/utils/validator.dart';
import 'package:pingolearn/view/pages/new_screen.dart';
import 'package:pingolearn/view/pages/register.dart';
import 'package:pingolearn/view/viewUtils/app_button.dart';
import 'package:pingolearn/view/viewUtils/customForm/custom_form_widget.dart';
import 'package:pingolearn/view/viewUtils/customForm/custom_text_field.dart';
import 'package:pingolearn/view/viewUtils/news_app_bar.dart';
import 'package:pingolearn/viewModel/future_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with RouteAware {
  late TextEditingController emailIdController;
  late TextEditingController passwordController;
  final GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();

  @override
  void initState() {
    super.initState();
    emailIdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Config.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    emailIdController.dispose();
    passwordController.dispose();
    Config.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    formKey.currentState?.reset();
    emailIdController.clear();
    passwordController.clear();
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureProvider<void>(
        futureCallback: () => ApiService.signIn(
            email: emailIdController.text, password: passwordController.text),
        builder: (context, child) {
          return Scaffold(
            appBar: const NewsAppBar(),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            body: CustomForm(
                formKey: formKey,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? 0
                                : MediaQuery.of(context).size.height * 0.18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: CustomTextFormField(
                                controller: emailIdController,
                                hintText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                  UpperCaseFormatter()
                                ],
                                validator: Validator.validEmail,
                              ),
                            ),
                            CustomTextFormField(
                              controller: passwordController,
                              passwordObsureIcon: true,
                              hintText: "Password",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 12),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: AppButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await context
                                        .read<CustomFutureNotifier<void>>()
                                        .callFuture<FirebaseAuthException>(
                                          successMessage: "Logged In",
                                          errorMessage: (error, stackTrace) =>
                                              error.code
                                                  .replaceAll("-", " ")
                                                  .toUpperCase(),
                                        );
                                    if (context.mounted) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NewScreen()));
                                    }
                                  }
                                },
                                child: Consumer<CustomFutureNotifier<void>>(
                                    builder: (context, ref, child) {
                                  if (ref.asyncValue.status ==
                                      ApiStatusEnum.loading) {
                                    return const Center(
                                        child:
                                            CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white,
                                    ));
                                  } else {
                                    return Text("Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary));
                                  }
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "New here? ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                TextSpan(
                                    text: "SignUp",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterScreen())),
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
                    )
                  ],
                )),
          );
        });
  }
}
