import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/package.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/add_package_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/package_item.dart';
import 'package:provider/provider.dart';

class SettingsScreen04 extends StatefulWidget {
  @override
  _SettingsScreen04State createState() => _SettingsScreen04State();
}

class _SettingsScreen04State extends State<SettingsScreen04> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "gallery": null,
  };

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateUserProfile(formData);
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
      }
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      margin: EdgeInsets.only(top: 10, bottom: defaultPadding),
      child: Stack(
        children: [
          user!["packages"].length == 0
              ? Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      "No Images/Videos in your gallery currently.",
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: user["packages"].length,
                  itemBuilder: (context, index) {
                    return PackageItem(
                      id: user["packages"][index]["_id"],
                      title: user["packages"][index]["title"],
                      description: user["packages"][index]["description"],
                      imageUrl: user["packages"][index]["image"],
                      price: user["packages"][index]['price'],
                    );
                  },
                ),
          Positioned(
            top: size.height - 250,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: secondaryColor,
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPackageScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
