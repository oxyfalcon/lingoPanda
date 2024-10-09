import 'package:flutter/material.dart';
import 'package:pingolearn/viewModel/form_validator_provider.dart';
import 'package:provider/provider.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<CustomFormState>? formKey;
  const CustomForm({super.key, this.formKey, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormValidatorProvider>(
      create: (context) => FormValidatorProvider(false),
      builder: (context, child) => _CustomForm(
        key: formKey,
        onChanged: () {
          if (context.read<FormValidatorProvider>().value) {
            formKey!.currentState!.validate();
          }
        },
        child: this.child,
      ),
    );
  }
}

class _CustomForm extends Form {
  const _CustomForm(
      {super.key, required super.child, required super.onChanged});

  @override
  FormState createState() => CustomFormState();
}

class CustomFormState extends FormState {
  @override
  bool validate() {
    Provider.of<FormValidatorProvider>(context, listen: false).value = true;
    return super.validate();
  }

  @override
  void reset() {
    super.reset();
    Provider.of<FormValidatorProvider>(context, listen: false).value = false;
  }
}
