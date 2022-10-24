import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class VerticalDetailField extends StatelessWidget {
  VerticalDetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: textSecondaryColor.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
