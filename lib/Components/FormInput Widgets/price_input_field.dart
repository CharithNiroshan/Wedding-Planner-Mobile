import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class PriceInputField extends StatelessWidget {
  PriceInputField({
    required this.label,
    required this.validator,
    required this.onSaved,
    required this.icon,
    this.initialValue,
  });

  final IconData icon;
  final String label;
  final String? initialValue;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
            ),
            labelText: label,
          ),
          textInputAction: TextInputAction.next,
          validator: validator,
          onSaved: onSaved,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
