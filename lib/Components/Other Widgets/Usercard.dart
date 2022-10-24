import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Consumer<Auth>(
          builder: (context, auth, child) => auth.isAuth
              ? Column(
                  children: [
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(
                        'https://$domainName/${auth.user!["profileImage"]}',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      auth.user!["fullName"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      auth.user!["email"],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                )
              : Text("Not Auth"),
        ),
      ),
    );
  }
}
