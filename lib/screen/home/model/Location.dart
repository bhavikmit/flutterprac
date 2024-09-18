import 'package:flutter/material.dart';

class Location {
  final String title;
  final String locationName;
  final String subtitle;
  final String imageUrl;
  final String btc;

  Location(
      {required this.title,
      required this.locationName,
      required this.imageUrl,
      required this.btc,
      required this.subtitle});
}
