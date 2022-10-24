import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/buisness_profile_card.dart';
import 'package:magula_mobile/providers/buisnessprofiles.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/buisnessprofile_screen.dart';
import 'package:provider/provider.dart';

class BuisnessProfileGrid extends StatefulWidget {
  BuisnessProfileGrid({this.category});

  final String? category;

  @override
  State<BuisnessProfileGrid> createState() => _BuisnessProfileGridState();
}

class _BuisnessProfileGridState extends State<BuisnessProfileGrid> {
  bool _isInit = true;
  bool _isLoading = true;

  void didChangeDependencies() async {
    if (_isInit) {
      if (widget.category != null) {
        await Provider.of<BuisnessProfiles>(context)
            .fetchAndSetBuisnessProfilesByCategory(widget.category as String);
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final buisnessProfileData = Provider.of<BuisnessProfiles>(context);
    final buisnessProfiles = buisnessProfileData.items;

    return _isLoading
        ? Container(
            width: double.infinity,
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : buisnessProfiles.length == 0
            ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/clipart1638671.png",
                      width: 100,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Vendors Found",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: buisnessProfiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 6.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => BuisnessProfileCard(
                  title: buisnessProfiles[index].title as String,
                  numOfReviews: buisnessProfiles[index].noOfReviews as int,
                  logoSrc: buisnessProfiles[index].logo as String,
                  rating: buisnessProfiles[index].rating as double,
                  category: buisnessProfiles[index].category as String,
                  coverPhotoSrc: buisnessProfiles[index].coverPhoto as String,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuisnessProfileScreen(
                                  id: buisnessProfiles[index].id as String,
                                )));
                  },
                ),
              );
  }
}
