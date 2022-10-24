import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/buisness_profiles_grid_view.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/models/category.dart';

class Body extends StatelessWidget {
  final itemsList = [
    Category(
      id: "1",
      title: "Decorations",
      imgSrc: "images/1644075315986-decorations.jpeg",
    ),
    Category(
      id: "2",
      title: "Music Groups",
      imgSrc: "images/1644075316754-music.jpg",
    ),
    Category(
      id: "3",
      title: "Dancing Groups",
      imgSrc: "images/1644075316731-dancing.jpg",
    ),
    Category(
      id: "4",
      title: "Photography",
      imgSrc: "images/1644075315487-photography.jpg",
    ),
    Category(
      id: "5",
      title: "Bridal Dressing",
      imgSrc: "images/1644075316781-bridal-dressing.jpg",
    ),
    Category(
      id: "6",
      title: "Groom Dressing",
      imgSrc: "images/1644075392394-groom-dressing.jpeg",
    ),
    Category(
      id: "7",
      title: "Cake Design",
      imgSrc: "images/1644075392394-cake.jpeg",
    ),
  ];

  final tabContent = [
    BuisnessProfileGrid(
      category: "Decorations",
    ),
    BuisnessProfileGrid(
      category: "Music Groups",
    ),
    BuisnessProfileGrid(
      category: "Dancing Groups",
    ),
    BuisnessProfileGrid(
      category: "Photography",
    ),
    BuisnessProfileGrid(
      category: "Bridal Dressing",
    ),
    BuisnessProfileGrid(
      category: "Groom Dressing",
    ),
    BuisnessProfileGrid(
      category: "Cake Design",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade600,
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            isScrollable: true,
            indicatorColor: secondaryColor,
            tabs: itemsList
                .map((item) => Tab(
                      text: item.title as String,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: TabBarView(
            children: tabContent,
          ),
        ),
      ],
    );
  }
}
