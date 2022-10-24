import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/buisnessprofile_info.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/service_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Details%20Page/Components/body.dart';
import 'package:provider/provider.dart';

class ContactDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DetailsField(
              icon: Icons.email,
              label: "Email",
              value: user!["email"],
            ),
            DetailsField(
              icon: Icons.phone,
              label: "Contact No",
              value: user["contactNo"],
            ),
            DetailsField(
              icon: Icons.location_on,
              label: "Address",
              value: user["address"],
            ),
            DetailsField(
              icon: Icons.location_city,
              label: "District",
              value: user["district"],
            ),
            ServicesField(
              icon: Icons.work,
              label: "Services",
              services: user["services"],
            )
          ],
        ),
      ),
    );
  }
}

class ServicesField extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<dynamic> services;

  ServicesField(
      {required this.icon, required this.label, required this.services});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 17,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: services
                  .map((service) => ServiceCard(title: service))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
