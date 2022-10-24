import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/buisness_profiles_grid_view.dart';
import 'package:magula_mobile/Components/Other%20Widgets/not_auth_screen.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) => auth.isAuth
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            )
          : NotAuthScreen(),
    );
  }
}
