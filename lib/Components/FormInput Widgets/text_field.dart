import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class FormTextField extends StatelessWidget {
  FormTextField({
    required this.label,
    required this.validator,
    required this.onSaved,
    required this.icon,
    this.initialValue,
    this.keyboardType,
    this.prefixText,
  });

  final IconData icon;
  final String label;
  final String? initialValue;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;
  final TextInputType? keyboardType;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixText: prefixText != null ? prefixText : null,
            prefixIcon: Icon(
              icon,
            ),
            labelText: label,
          ),
          textInputAction: TextInputAction.next,
          validator: validator,
          onSaved: onSaved,
          keyboardType:
              keyboardType != null ? keyboardType : TextInputType.text,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
