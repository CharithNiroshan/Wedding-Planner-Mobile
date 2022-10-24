import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/package.dart';
import 'package:provider/provider.dart';

class PackagesFieldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: user!["packages"].length == 0
          ? Center(
              child: Text(
                "No packages in your account.",
              ),
            )
          : ListView.builder(
              itemCount: user["packages"].length,
              itemBuilder: (context, index) {
                return Package(
                  title: user["packages"][index]["title"],
                  imgSrc: user["packages"][index]["image"],
                  price: user["packages"][index]["price"],
                );
              },
            ),
    );
  }
}
