import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/booking_details.dart';

class BookingCard extends StatelessWidget {
  BookingCard({
    required this.id,
    required this.category,
    required this.title,
    required this.imgSrc,
    required this.status,
    required this.date,
  });

  final String id, category, title, imgSrc, date;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailsScreen(
              id: id,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
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
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage("https://$domainName/$imgSrc"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Booking Date : $date",
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            status
                ? Text(
                    "Pending",
                  )
                : Text(
                    "Rejected",
                  )
          ],
        ),
      ),
    );
  }
}
