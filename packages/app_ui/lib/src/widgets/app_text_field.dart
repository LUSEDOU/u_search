import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template app_text_field}
/// A text field component based on material [TextFormField] widget with a
/// fixed, left-aligned label text displayed above the text field.
/// {@endtemplate}
class AppTextField extends StatelessWidget {
  /// {@macro app_text_field}
  const AppTextField({
    super.key,
    this.initialValue,
    this.autoFillHints,
    this.controller,
    this.inputFormatters,
    this.autocorrect = true,
    this.readOnly = false,
    this.hintText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.maxLines,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.isRequired,
    this.label,
    this.autofocus,
  });

  /// A value to initialize the field to.
  final String? initialValue;

  /// List of auto fill hints.
  final Iterable<String>? autoFillHints;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum number of lines to allow when entering text.
  /// Defaults to 1.
  final int? maxLines;

  /// Whether to enable autocorrect.
  /// Defaults to true.
  final bool autocorrect;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool readOnly;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text that appears below the field.
  final String? errorText;

  /// A widget that appears before the editable part of the text field.
  final Widget? prefix;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// The label text displayed above the text field.
  final String? label;

  /// Whether the field is required.
  final bool? isRequired;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  final TextInputType? keyboardType;

  /// Called when the form field is saved.
  final FormFieldSetter<String>? onSaved;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// Called when the text field has been tapped.
  final VoidCallback? onTap;

  /// An optional function to validate the input.
  final String? Function(String?)? validator;

  /// Whether the text field should be autofocused.
  final bool? autofocus;

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: AppColors.mediumEmphasisSurface,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 80),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              key: key,
              initialValue: initialValue,
              maxLines: maxLines,
              controller: controller,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              autocorrect: autocorrect,
              readOnly: readOnly,
              autofillHints: autoFillHints,
              cursorColor: AppColors.darkAqua,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              autofocus: autofocus ?? false,
              onFieldSubmitted: onSubmitted,
              onSaved: onSaved,
              autovalidateMode: switch (isRequired) {
                true => AutovalidateMode.onUserInteraction,
                false => AutovalidateMode.disabled,
                null => null,
              },
              validator: isRequired == null && validator == null
                  ? null
                  : (value) {
                      if (isRequired ?? false) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido.';
                        }
                      }
                      return validator?.call(value);
                    },
              decoration: InputDecoration(
                hintText: hintText,
                errorText: errorText,
                prefixIcon: prefix,
                suffixIcon: suffix,
                suffixIconConstraints: const BoxConstraints.tightFor(
                  width: 32,
                  height: 32,
                ),
                prefixIconConstraints: const BoxConstraints.tightFor(
                  width: 48,
                ),
                labelText: label,
                fillColor: theme.colorScheme.surface,
                focusColor: theme.colorScheme.primary.withOpacity(0.1),
                hoverColor: theme.colorScheme.primary.withOpacity(0.1),
                border: _border,
                enabledBorder: _border,
                errorBorder: _border.copyWith(
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                  ),
                ),
                focusedErrorBorder: _border.copyWith(
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                  ),
                ),
                focusedBorder: _border.copyWith(
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              onChanged: onChanged,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
