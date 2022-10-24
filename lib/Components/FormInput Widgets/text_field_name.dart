import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class TextFieldName extends StatelessWidget {
  TextFieldName({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
      ),
    );
  }
}
