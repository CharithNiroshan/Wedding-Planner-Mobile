import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class Package extends StatelessWidget {
  Package({
    required this.title,
    required this.imgSrc,
    required this.price,
  });

  final String title, imgSrc;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: 220,
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
      child: Column(
        children: [
          Image.network(
            "https://$domainName/$imgSrc",
            height: 175,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PriceTag(
                  price: price,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  PriceTag({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PriceClipper(),
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        height: 80,
        width: 70,
        color: Colors.yellow.shade800,
        child: Column(
          children: [
            Text(
              "Rs.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$price/=",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
