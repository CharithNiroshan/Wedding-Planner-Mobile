import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magula_mobile/constants.dart';

class Review extends StatelessWidget {
  Review({
    required this.fullName,
    required this.description,
    required this.profileImageSrc,
    required this.date,
    required this.rating,
  });

  final String fullName, profileImageSrc, description, date;
  final double rating;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
            children: [
              CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage("https://$domainName/$profileImageSrc")),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RatingBarIndicator(
                rating: rating.toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.yellow.shade800,
                ),
                itemCount: 5,
                itemSize: 17.0,
                direction: Axis.horizontal,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(description),
        ],
      ),
    );
  }
}
