import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/Components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/Components/body.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = "/categories";
  const CategoriesScreen({Key? key, this.category}) : super(key: key);

  final String? category;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> categories = [
    "Decorations",
    "Music Groups",
    "Dancing Groups",
    "Photography",
    "Bridal Dressing",
    "Groom Dressing",
    "Cake Design",
  ];

  int index = 0;

  void initState() {
    if (widget.category != null) {
      index = categories.indexOf(widget.category as String);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(index);
    return DefaultTabController(
      initialIndex: index,
      length: 7,
      child: Scaffold(
        appBar: categoriesScreenAppBar(context),
        body: Body(),
      ),
    );
  }
}
