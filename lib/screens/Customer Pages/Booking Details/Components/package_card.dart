import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/package.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  final String image, title, description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Package",
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
          Row(
            children: [
              Image.network(
                "https://$domainName/$image",
                width: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PriceTag(
                      price: price,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: textPrimaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
