import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:provider/provider.dart';

class BuisneesProfileTopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            buisnessProfile["accountCategory"],
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buisnessProfile["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buisnessProfile["reviews"].length == 0
                        ? Text(
                            "No Rated Yet",
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating:
                                        buisnessProfile["rating"].toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade800,
                                    ),
                                    itemCount: 5,
                                    itemSize: 17.0,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    buisnessProfile["rating"]
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${buisnessProfile["reviews"].length} Reviews',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  "https://$domainName/${buisnessProfile["logo"]}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
