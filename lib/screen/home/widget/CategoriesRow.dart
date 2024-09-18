import 'package:flutter/material.dart';
import 'package:flutterprac/utils/constants.dart';
import '../model/Category.dart';
import 'CategoryCard.dart';

class CategoriesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      // Two columns
      shrinkWrap: true,
      // Prevents GridView from taking up all available space
      physics: NeverScrollableScrollPhysics(),
      // Disables scrolling within the GridView
      childAspectRatio: 1.5,
      // Adjust this for the desired width/height ratio
      mainAxisSpacing: 10.0,
      // Adjust spacing between rows
      crossAxisSpacing: 10.0,
      // Adjust spacing between columns
      children: [
        CategoryCard(
            category: Category(name: 'Nature', imagePath: Constant.nature)),
        CategoryCard(
            category: Category(name: 'Future', imagePath: Constant.future)),
        CategoryCard(
            category:
                Category(name: 'Futuristic', imagePath: Constant.futuristic)),
        // Add more CategoryCard widgets if needed
      ],
    );
  }
}
