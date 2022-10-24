import 'package:flutter/material.dart';
import 'package:magula_mobile/providers/categories.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/categories_screen.dart';
import 'package:provider/provider.dart';

class CategoryCardScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Categories>(context, listen: false);
    final categories = categoriesData.categories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: categories
              .map((category) => CategoryCard(
                    title: category.title as String,
                    imgSrc: category.imgSrc as String,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title, imgSrc;

  CategoryCard({required this.title, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesScreen(
              category: title,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundImage: NetworkImage(imgSrc),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
