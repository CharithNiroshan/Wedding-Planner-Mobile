import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/cover_image.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Package%20Page/Components/app_bar.dart';

class PackageScreen extends StatelessWidget {
  PackageScreen({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
  });

  final String title, image, description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: packageScreenAppBar(context, title),
      body: Column(
        children: [
          CoverImage(
            imgSrc: image,
          ),
        ],
      ),
    );
  }
}
