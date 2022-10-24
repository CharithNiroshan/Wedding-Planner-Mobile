import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/loading_screen.dart';
import 'package:magula_mobile/models/buisnessprofile.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/body.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/bottom_navigator_bar.dart';
import 'package:provider/provider.dart';

class BuisnessProfileScreen extends StatefulWidget {
  static const routeName = "/buisness-profile-details";

  final String id;

  const BuisnessProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<BuisnessProfileScreen> createState() => _BuisnessProfileScreenState();
}

class _BuisnessProfileScreenState extends State<BuisnessProfileScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  void didChangeDependencies() async {
    if (_isInit) {
      try {
        await Provider.of<BuisnessProfileProvider>(context)
            .fetchBuisnessprofile(widget.id);
        _isLoading = false;
      } catch (err) {
        throw err;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
            appBar: buisnessProfileAppBar(context),
            body: Body(),
            bottomNavigationBar: BuisnessProfileBottomNavigatorBar(),
          );
  }
}
