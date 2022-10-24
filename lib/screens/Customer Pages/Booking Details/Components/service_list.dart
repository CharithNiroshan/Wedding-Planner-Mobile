import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    required this.services,
  });

  final List<dynamic> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Services",
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
        Container(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: services
                .map(
                  (service) => Column(
                    children: [
                      Text(
                        service,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
