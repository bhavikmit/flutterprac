import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterprac/utils/colors.dart';

import 'CalendarWidget.dart';

class LoadingBottomSheet extends StatefulWidget {
  @override
  _LoadingBottomSheetState createState() => _LoadingBottomSheetState();
}

class _LoadingBottomSheetState extends State<LoadingBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  List<String> timeSlots = ['05:00 AM', '12:30 PM', '06:00 PM', '09:00 PM'];
  int? selectedIndex; // To track the selected item
  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Define the slide animation
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from below the screen
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _startLoadingTimer();
  }

  void _startLoadingTimer() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      _animationController
          .forward(); // Start the slide animation after loading is done
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            // Center the loading indicator within the bottom sheet
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    strokeWidth: 8.0,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Finding your location',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'One moment while we get your location',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          )
        : SlideTransition(
            position: _slideAnimation,
            // Apply the slide animation
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 16, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lagos, LOS',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('FROM NIGERIA', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 16),
                        Text('Santorini, Chevok Port 2',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('TO NEW OSOGBO', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  Container(height: 1,color: Colors.white.withOpacity(0.2),),
                  SizedBox(height: 15,),
                  Center(
                    child: Text('Trip Calendar',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: CalendarWidget(), // Custom Calendar Widget
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('DEPARTURE TIME',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        return _buildTimeSlotItem(
                            index); // Extract item building into a separate method
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRedButton('SEATS'),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
  }
  Widget _buildRedButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(color: Colors.white)),
            ],
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTimeSlotItem(int index) {
    bool isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex =
              (selectedIndex == index) ? null : index; // Toggle selection
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.red : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          // Center the text for better visual alignment
          child: Text(
            timeSlots[index],
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
