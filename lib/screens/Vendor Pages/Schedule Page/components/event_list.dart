import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Schedule%20Page/components/event_card.dart';

class WeekEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your events for week time",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 5,
          ),
          child: Column(
            children: [
              EventCard(),
              EventCard(),
              EventCard(),
            ],
          ),
        ),
      ],
    );
  }
}
