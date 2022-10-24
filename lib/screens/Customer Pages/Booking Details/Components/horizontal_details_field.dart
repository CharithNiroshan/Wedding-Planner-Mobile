import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class HorizontalDetailField extends StatelessWidget {
  HorizontalDetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "$label : ",
              style: TextStyle(
                color: textSecondaryColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
