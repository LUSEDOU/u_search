import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template app_email_text_field}
/// An email text field component.
/// {@endtemplate}
class AppEmailTextField extends StatelessWidget {
  /// {@macro app_email_text_field}
  const AppEmailTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readOnly,
    this.onChanged,
    this.onSaved,
    this.autofocus,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool? readOnly;

  /// Whether the text field should be autofocused.
  final bool? autofocus;

  /// Called when the form is saved.
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      autoFillHints: const [AutofillHints.email],
      autocorrect: false,
      autofocus: autofocus,
      onSaved: onSaved,
      onSubmitted: onSaved,
      prefix: const Padding(
        padding: EdgeInsets.all(AppSpacing.sm),
        child: Icon(
          Icons.email_outlined,
          color: AppColors.mediumEmphasisSurface,
          size: 24,
        ),
      ),
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      suffix: suffix,
    );
  }
}
