import "package:flutter/material.dart";
import 'package:magula_mobile/constants.dart';

class BuisnessProfileCard2 extends StatelessWidget {
  BuisnessProfileCard2({
    required this.title,
    required this.numOfReviews,
    required this.logoSrc,
    required this.rating,
    required this.category,
    required this.coverPhotoSrc,
    required this.onTap,
  });

  final int id = 1;
  final String title, logoSrc, category, coverPhotoSrc;
  final int numOfReviews;
  final double rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.55,
        margin: EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Image.network(
                  coverPhotoSrc,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.only(
                    top: 40,
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultPadding,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      50,
                    ),
                  ),
                ),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(logoSrc),
                ),
              ),
              top: 116,
              left: ((size.width * 0.55) - 68) / 2,
            ),
          ],
        ),
      ),
    );
  }
}
