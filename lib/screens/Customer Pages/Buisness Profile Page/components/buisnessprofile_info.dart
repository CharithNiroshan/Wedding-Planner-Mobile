import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/package.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/review.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/service_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/top_card.dart';
import 'package:provider/provider.dart';

class BuisnessProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuisneesProfileTopCard(),
            ServiceCardList(),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                buisnessProfile["description"],
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 1.5,
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            PackagesField(),
            const SizedBox(
              height: defaultPadding,
            ),
            GalleryField(),
            const SizedBox(
              height: defaultPadding,
            ),
            ReviewField(),
          ],
        ),
      ),
    );
  }
}

class ServiceCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    return Container(
      height: 38,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: buisnessProfile["services"].length,
        itemBuilder: (context, index) => ServiceCard(
          title: buisnessProfile["services"][index],
        ),
      ),
    );
  }
}

class PackagesField extends StatelessWidget {
  const PackagesField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Packages",
                style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (buisnessProfile["packages"].length == 0)
                Text("( No packages yet. ) ")
            ],
          ),
        ),
        Container(
          height: 320,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buisnessProfile["packages"].length,
            itemBuilder: (context, index) => Package(
              title: buisnessProfile["packages"][index]["title"],
              imgSrc: buisnessProfile["packages"][index]["image"],
              price: buisnessProfile["packages"][index]["price"],
            ),
          ),
        )
      ],
    );
  }
}

class GalleryField extends StatelessWidget {
  const GalleryField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Gallery",
              style: TextStyle(
                color: textPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            buisnessProfile["gallery"].length == 0
                ? Text("( No items yet. ) ")
                : Text("( ${buisnessProfile["gallery"].length} Items )")
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buisnessProfile["gallery"].length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.network(
                "https://$domainName/${buisnessProfile["gallery"][index]}",
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ReviewField extends StatelessWidget {
  const ReviewField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfileProvider>(context);
    final buisnessProfile = buisnessProfileData.buisnessProfile;

    print(buisnessProfile["reviews"][2]);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                color: textPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            buisnessProfile["reviews"].length == 0
                ? Text("( No reviews yet. ) ")
                : Text("( ${buisnessProfile["reviews"].length} reviews )")
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buisnessProfile["reviews"].length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(right: 10),
              child: Review(
                fullName: buisnessProfile["reviews"][index]["user"]["fullName"],
                profileImageSrc: buisnessProfile["reviews"][index]["user"]
                    ["profileImage"],
                rating: buisnessProfile["reviews"][index]["rating"].toDouble(),
                description: buisnessProfile["reviews"][index]["description"],
                date: buisnessProfile["reviews"][index]["Date"],
              ),
            ),
          ),
        )
      ],
    );
  }
}
