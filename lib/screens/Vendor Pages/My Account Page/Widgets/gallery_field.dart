import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:provider/provider.dart';

class GalleryFieldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: user!["gallery"].length == 0
          ? Center(
              child: Text(
                "No images in your gallery.",
              ),
            )
          : ListView.builder(
              itemCount: user["gallery"].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.network(
                    "https://$domainName/${user["gallery"][index]}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
