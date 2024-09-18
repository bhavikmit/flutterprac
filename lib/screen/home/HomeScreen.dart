import 'package:flutter/material.dart';
import 'package:flutterprac/screen/home/widget/CategoriesRow.dart';
import 'package:flutterprac/screen/locationdetail/LocationDetail.dart';
import 'package:flutterprac/utils/colors.dart';
import 'package:flutterprac/utils/constants.dart';

import 'model/Location.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(Constant.discover,
            style: TextStyle(fontSize: 24, color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification icon press
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.account_circle_sharp, color: Colors.white),
              onPressed: () {
                // Handle account icon press
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constant.trending,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 5),
            LocationSlider(),
            SizedBox(height: 20),
            Text(
              Constant.feelingadv,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              Constant.inspiration,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            CategoriesRow(),
          ],
        ),
      ),
    );
  }
}

// LocationSlider
class LocationSlider extends StatelessWidget {
  final List<Location> locations = [
    Location(
      title: 'VR',
      subtitle: 'Ophiuchi',
      locationName: 'Kaduna',
      imageUrl: Constant.nature1,
      btc: '0.4 BTC',
    ),
    Location(
      title: 'VR',
      subtitle: 'Mars Exploration',
      locationName: 'Mars',
      imageUrl: Constant.futuristic1,
      btc: '1.2 BTC',
    ),
    Location(
      subtitle: 'Beach Paradise',
      title: 'VR',
      locationName: 'Maldives',
      imageUrl: Constant.future1,
      btc: '0.7 BTC',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: PageView.builder(
        itemCount: locations.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return LocationCard(location: locations[index]);
        },
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final Location location;

  LocationCard({required this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LocationDetail(location: this.location),
            transitionDuration: Duration(milliseconds: 800), // Adjust the duration as needed
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // You can customize the transition animation here if needed
              // For now, let's keep the default MaterialPageRoute fade transition
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.black.withOpacity(0.8)],
            // Adjust opacity as needed
          ),
        ),
        child: Stack(
          children: [
            Hero( // Wrap the location name Text widget in a Hero
              tag: '${location.imageUrl}_title', // Unique tag for the title
              child: Material( // Add Material for better animation
                type: MaterialType.transparency,
                child:Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    // Wrap the Image.asset in a ClipRRect
                    borderRadius: BorderRadius.circular(10.0),
                    // Adjust the radius as needed
                    child: Image.asset(
                      location.imageUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            // Background Image


            // Text and Icons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Image.asset(Constant.vr),
                              Icon(
                                size: 20,
                                Icons.vrpano_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                location.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            location.locationName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            location.locationName,
                            style: TextStyle(
                              color: AppColors.opasitywhite,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                              5), // Adjust for desired roundness
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          // Keep the button compact
                          children: [
                            Icon(Icons.notifications, color: Colors.white),
                            SizedBox(width: 8), // Space between icon and text
                            Text(
                              '0.6 BTC',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
