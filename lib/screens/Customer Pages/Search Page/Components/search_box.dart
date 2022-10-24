import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/Components/filter_bottom_sheet.dart';

class SearchBox extends StatefulWidget {
  SearchBox({
    required this.searchValues,
    required this.onChanged,
  });

  final String? Function(String?) onChanged;
  final Map<String, dynamic> searchValues;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "What are you looking for...",
          border: searchBoxBorder,
          enabledBorder: searchBoxBorder,
          focusedBorder: searchBoxBorder,
          errorBorder: searchBoxBorder,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: Icon(
              Icons.search,
              color: textSecondaryColor,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return FilterSelectorBottomSheet(
                    searchValues: widget.searchValues,
                  );
                },
              );
            },
            icon: Icon(
              Icons.filter_alt,
              color: textSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
