import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Details%20Page/Components/body.dart';
import 'package:provider/provider.dart';

class BasicDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundImage:
                  NetworkImage("https://$domainName/${user!["logo"]}"),
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
                  icon: Icons.apartment,
                  label: "Title",
                  value: user["title"],
                ),
                DetailsField(
                  icon: Icons.note,
                  label: "Description",
                  value: user["description"],
                ),
                DetailsField(
                  icon: Icons.category,
                  label: "Category",
                  value: user["accountCategory"],
                ),
                ImageField(
                  icon: Icons.image,
                  label: "Cover Photo",
                  url: user["coverPhoto"],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  final IconData icon;
  final String url, label;

  ImageField({required this.icon, required this.url, required this.label});

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
          Image.network("https://$domainName/$url")
        ],
      ),
    );
  }
}
