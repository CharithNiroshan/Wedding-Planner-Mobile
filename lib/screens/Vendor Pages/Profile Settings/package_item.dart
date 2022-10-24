import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/edit_package_screen.dart';
import 'package:provider/provider.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class PackageItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final String description;

  PackageItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool _isLoading = false;

  void onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Do you want to confirm the delete request?"),
        actions: [
          TextButton(
            child: Text("Yes"),
            onPressed: delete,
          ),
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void delete() async {
    print("sdas");
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .deletePackageFromVendorProfile(widget.id);
      setState(() {
        _isLoading = false;
      });
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              "https://$domainName/${widget.imageUrl}",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                PopupMenuButton(
                  onSelected: (result) {
                    if (result == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPackageScreen(
                            id: widget.id,
                            title: widget.title,
                            description: widget.description,
                            imageUrl: widget.imageUrl,
                            price: widget.price,
                          ),
                        ),
                      );
                    } else if (result == 1) {
                      onDelete(context);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Edit"),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text("Delete"),
                      value: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
