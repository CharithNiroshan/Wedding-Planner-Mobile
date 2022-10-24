import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundImage:
                  NetworkImage("https://$domainName/${user!["profileImage"]}"),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DetailsField(
                  icon: Icons.person,
                  label: "Full Name",
                  value: user["fullName"],
                ),
                DetailsField(
                  icon: Icons.verified_user,
                  label: "Display Name",
                  value: user["displayName"],
                ),
                DetailsField(
                  icon: Icons.email,
                  label: "Email",
                  value: user["email"],
                ),
                DetailsField(
                  icon: Icons.phone,
                  label: "Contact No",
                  value: user["contactNo"],
                ),
                // DetailsField(
                //   icon: Icons.calendar_today,
                //   label: "Wedding Date",
                //   value: user["weddingDate"] ,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsField extends StatelessWidget {
  final IconData icon;
  final String value, label;

  DetailsField({required this.icon, required this.value, required this.label});

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
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
