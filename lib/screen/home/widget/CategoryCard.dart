
import 'package:flutter/material.dart';

import '../model/Category.dart';

class CategoryCard extends StatefulWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(widget.category.imagePath), // Assuming Category has an imagePath
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          widget.category.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Optionally make the text bold
          ),
        ),
      ),
    );
  }
}