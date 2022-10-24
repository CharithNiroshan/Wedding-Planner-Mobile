import 'package:flutter/material.dart';
import 'package:magula_mobile/providers/buisnessprofiles.dart';
import 'package:magula_mobile/providers/categories.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/components/buisness_profiles_scroll_view.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/components/category_card_scroll_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  void didChangeDependencies() async {
    if (_isInit) {
      try {
        await Provider.of<BuisnessProfiles>(context)
            .fetchAndSetBuisnessProfiles();
        await Provider.of<Categories>(context, listen: false)
            .fetchAndSetCategories();
        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        print(err);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                CategoryCardScrollView(),
                BuisnessProfilesHorizontalScrollView(
                  title: "Top Rated Decorators",
                ),
                BuisnessProfilesHorizontalScrollView(
                  title: "Top Rated Photographers",
                ),
                BuisnessProfilesHorizontalScrollView(
                  title: "Top Rated Music Groups",
                ),
                BuisnessProfilesHorizontalScrollView(
                  title: "Top Rated Dancing Groups",
                ),
              ],
            ),
          );
  }
}
