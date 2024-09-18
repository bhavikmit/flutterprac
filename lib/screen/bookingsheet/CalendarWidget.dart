import 'package:flutter/material.dart';
import 'package:flutterprac/utils/colors.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDate = DateTime.now();

  // ... (other functions remain the same) ...

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    int daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;

    // Calculate the number of days to display to ensure all dates are visible
    int totalDaysToDisplay = (daysInMonth + firstDayOfMonth.weekday - 1) % 7 == 0
        ? (daysInMonth + firstDayOfMonth.weekday - 1)
        : (daysInMonth + firstDayOfMonth.weekday - 1) + 7 -
        ((daysInMonth + firstDayOfMonth.weekday - 1) % 7);

    // Generate the list of dates to display
    List<DateTime> calendarDates = List<DateTime>.generate(
      totalDaysToDisplay,
          (index) => firstDayOfMonth.add(Duration(days: index - firstDayOfMonth.weekday + 1)),
    );

    return Column(
      children: [
        // Horizontal ListView for month navigation
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 12, // 12 months
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedDate = DateTime(_focusedDate.year, index + 1);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: index + 1 == _focusedDate.month ? AppColors.red : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('MMM').format(DateTime(_focusedDate.year, index + 1)),
                      style: TextStyle(
                        color: index + 1 == _focusedDate.month ? Colors.white : Colors.grey,
                        fontWeight: index + 1 == _focusedDate.month ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Calendar grid
        SizedBox(height: 16),
        Container(
          height: 300,
          child: GridView.builder(
            itemCount: calendarDates.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              DateTime date = calendarDates[index];
              bool isCurrentMonth = date.month == _focusedDate.month;
              bool isSelected = date == _startDate || date == _endDate;
              bool isInRange = _startDate != null &&
                  _endDate != null &&
                  date.isAfter(_startDate!) &&
                  date.isBefore(_endDate!);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_startDate == null) {
                      _startDate = date;
                    } else if (_endDate == null) {
                      _endDate = date;
                      if (_endDate!.isBefore(_startDate!)) {
                        DateTime temp = _startDate!;
                        _startDate = _endDate;
                        _endDate = temp;
                      }
                    } else {
                      _startDate = date;
                      _endDate = null;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.red
                        : isInRange
                        ? AppColors.white.withOpacity(0.4)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCurrentMonth ? Colors.grey : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontWeight: isSelected || isInRange
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}