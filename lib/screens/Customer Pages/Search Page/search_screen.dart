import "package:flutter/material.dart";
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofiles.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/components/buisness_profiles_scroll_view.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/Components/search_box.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic> searchValues = {
    "query": null,
    "district": null,
    "category": null,
  };

  bool _loading = false;

  bool searchingFinished = false;

  final _formKey = GlobalKey<FormState>();

  void onSearch() async {
    print(searchValues);
    if (searchValues["query"] != null) {
      _formKey.currentState!.save();
      try {
        if (searchValues["query"] != null) {
          setState(() {
            _loading = true;
          });
          print("searching");
          await Provider.of<BuisnessProfiles>(context, listen: false)
              .fetchAndSetBuisnessProfilesBySearching(searchValues);
          setState(() {
            _loading = false;
            searchingFinished = true;
          });
        }
      } on Exception catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: SearchBox(
                      searchValues: searchValues,
                      onChanged: (value) {
                        searchValues["query"] = value;
                      },
                    ),
                  ),
                  if (searchValues["category"] == null &&
                      searchValues["district"] == null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                        top: defaultPadding,
                        bottom: defaultPadding,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "No Filters Added.",
                          ),
                        ],
                      ),
                    ),
                  if (searchValues["category"] != null ||
                      searchValues["district"] != null)
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Row(
                        children: [
                          Text(
                            "Filters Added.",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                searchValues["district"] = null;
                                searchValues["category"] = null;
                              });
                            },
                            child: Text(
                              "Clear Filters",
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  _loading
                      ? LoadingButton()
                      : Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(secondaryColor)),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            onPressed: onSearch,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
            if (searchingFinished)
              BuisnessProfilesHorizontalScrollView(
                title: "Results",
              ),
          ],
        ),
      ),
    );
  }
}
