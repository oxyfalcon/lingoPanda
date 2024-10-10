import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingopanda/viewModel/form_validator_provider.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends FormField<String> {
  CustomTextFormField({
    super.key,
    super.validator,
    required final TextEditingController controller,
    String? hintText,
    final TextCapitalization textCapitalization = TextCapitalization.none,
    final bool passwordObsureIcon = false,
    final TextInputType? keyboardType,
    final List<TextInputFormatter>? inputFormatters,
    final bool obscureText = false,
  }) : super(
          initialValue: controller.text,
          builder: (state) {
            void onFieldChangedCallBack(String? value) =>
                state.didChange(value);

            return _AppTextFormField(
              key: key,
              errorText: state.errorText,
              validator: validator,
              textCapitalization: textCapitalization,
              passwordObsureIcon: passwordObsureIcon,
              keyboardType: keyboardType,
              hintText: hintText,
              onFieldChanged: onFieldChangedCallBack,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              controller: controller,
            );
          },
        );
}

class _AppTextFormField extends StatefulWidget {
  final String? hintText;
  final TextCapitalization textCapitalization;
  final bool passwordObsureIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?) onFieldChanged;
  final String? errorText;
  final bool obscureText;

  const _AppTextFormField({
    super.key,
    required this.controller,
    required this.onFieldChanged,
    required this.obscureText,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.passwordObsureIcon = false,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
    this.validator,
  });

  @override
  State<_AppTextFormField> createState() => _AppTextFormFieldStateTwo();
}

class _AppTextFormFieldStateTwo extends State<_AppTextFormField> {
  bool _isTextObsure = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.validator != null) {
        widget.onFieldChanged.call(widget.controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [...?widget.inputFormatters],
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText:
          (widget.passwordObsureIcon) ? _isTextObsure : widget.obscureText,
      decoration: InputDecoration(
        errorText: widget.validator != null
            ? context.read<FormValidatorProvider>().value
                ? widget.errorText
                : null
            : null,
        isDense: true,
        hintText: widget.hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        suffixIcon: (widget.passwordObsureIcon)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isTextObsure = !_isTextObsure;
                  });
                },
                icon: Icon(
                  _isTextObsure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: const Color(0xFF9DA3AA),
                ))
            : null,
        errorMaxLines: 6,
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        errorBorder: widget.validator != null
            ? context.read<FormValidatorProvider>().value
                ? widget.errorText != null
                    ? OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      )
                    : null
                : null
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFCFCFD2))),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: widget.controller.text.isNotEmpty
                    ? const Color.fromRGBO(175, 175, 175, 1)
                    : const Color(0xFFCFCFD2))),
      ),
    );
  }
}
