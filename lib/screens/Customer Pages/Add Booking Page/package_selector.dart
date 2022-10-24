import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field_name.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/package.dart';
import 'package:provider/provider.dart';

class PackageSelector extends StatefulWidget {
  PackageSelector({
    required this.label,
    required this.onSaved,
  });

  final String label;
  final Function(Map<String, dynamic>?) onSaved;
  @override
  _PackageSelectorState createState() => _PackageSelectorState();
}

class _PackageSelectorState extends State<PackageSelector> {
  Map<String, dynamic>? value;

  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: false,
          child: TextFormField(
            onSaved: widget.onSaved(value),
          ),
        ),
        TextFieldName(text: widget.label),
        const SizedBox(height: 10),
        Container(
          height: 315,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buisnessProfile["packages"].length,
            itemBuilder: (context, index) => SelectorItem(
              title: buisnessProfile["packages"][index]["title"],
              image: buisnessProfile["packages"][index]["image"],
              price: buisnessProfile["packages"][index]["price"],
              isActive: value == null
                  ? false
                  : value!["_id"] == buisnessProfile["packages"][index]["_id"],
              onTap: () {
                setState(() {
                  value = buisnessProfile["packages"][index];
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}

class SelectorItem extends StatelessWidget {
  SelectorItem({
    required this.title,
    required this.image,
    required this.price,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final String image;
  final int price;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: isActive
            ? Border.all(
                color: secondaryColor,
                width: 2,
              )
            : Border.all(
                color: Colors.transparent,
              ),
      ),
      child: InkWell(
        onTap: onTap,
        child: SelectorPackage(
          title: title,
          imgSrc: image,
          price: price,
        ),
      ),
    );
  }
}

class SelectorPackage extends StatelessWidget {
  SelectorPackage({
    required this.title,
    required this.imgSrc,
    required this.price,
  });

  final String title, imgSrc;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: 220,
      child: Column(
        children: [
          Image.network(
            "https://$domainName/$imgSrc",
            height: 175,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PriceTag(
                  price: price,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
