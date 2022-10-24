import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  SearchBox({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          40,
        ),
        border: Border.all(
          color: Colors.grey.shade400.withOpacity(
            0.32,
          ),
        ),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'What are you looking for',
          icon: Icon(
            Icons.search,
          ),
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
