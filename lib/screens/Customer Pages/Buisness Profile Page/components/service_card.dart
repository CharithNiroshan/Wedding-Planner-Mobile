import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class ServiceCard extends StatelessWidget {
  final String title;

  const ServiceCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: textPrimaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textPrimaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
