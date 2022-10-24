import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:provider/provider.dart';

class CoverImage extends StatelessWidget {
  CoverImage({required this.imgSrc});

  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<BuisnessProfileProvider>(
      builder: (context, value, child) => Container(
        height: size.height * 0.34,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://$domainName/${value.buisnessProfile["coverPhoto"]}",
            ),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
