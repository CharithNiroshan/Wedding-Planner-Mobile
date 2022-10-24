import 'package:flutter/material.dart';
import 'package:magula_mobile/providers/categories.dart';
import 'package:provider/provider.dart';

class VendorHomeSccreen extends StatefulWidget {
  const VendorHomeSccreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeSccreen> createState() => _VendorHomeSccreenState();
}

class _VendorHomeSccreenState extends State<VendorHomeSccreen> {
  bool _isInit = true;

  void didChangeDependencies() async {
    if (_isInit) {
      try {
        await Provider.of<Categories>(context, listen: false)
            .fetchAndSetCategories();
      } catch (err) {
        print(err);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home",
      ),
    );
  }
}
