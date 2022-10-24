import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/Components/filter.dart';

class FilterSelectorBottomSheet extends StatefulWidget {
  const FilterSelectorBottomSheet({
    required this.searchValues,
  });

  final Map<String, dynamic> searchValues;

  @override
  State<FilterSelectorBottomSheet> createState() =>
      _FilterSelectorBottomSheetState();
}

class _FilterSelectorBottomSheetState extends State<FilterSelectorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filters",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Filter(
                  label: "Category",
                  items: [
                    "Decorations",
                    "Photography",
                    "Music Groups",
                    "Dancing Groups",
                    "Bridal Dressing",
                    "Groom Dressing",
                    "Cake Design",
                  ],
                  initialValue: widget.searchValues["category"],
                  onSaved: (value) {
                    widget.searchValues["category"] = value;
                  },
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Filter(
                  label: "District",
                  items: [
                    "Colombo",
                    "Kandy",
                    "Gampaha",
                    "Kaluthara",
                    "Galle",
                    "Mathara",
                    "Hambanthota",
                  ],
                  initialValue: widget.searchValues["district"],
                  onSaved: (value) {
                    widget.searchValues["district"] = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
