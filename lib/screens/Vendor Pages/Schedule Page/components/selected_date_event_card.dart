import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Schedule%20Page/components/event_card.dart';

class CurrentDateEventsCard extends StatelessWidget {
  CurrentDateEventsCard({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey.shade300,
      )),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: defaultPadding,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Today - ${DateFormat('dd/MM/yyyy').format(date)} ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.yellow.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.yellow.shade800,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Events",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: EventCard(),
          ),
        ],
      ),
    );
  }
}
