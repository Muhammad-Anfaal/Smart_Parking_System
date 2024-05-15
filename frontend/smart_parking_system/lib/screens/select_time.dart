import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  DateTime today = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double perHourRate = 50.0;

  Future<void> selectTime(String startTime, String endTime, String amount,
      String date, String email) async {
    String ipAddress = '192.168.137.1'; // lan adapter ip address
    final url = Uri.parse('http://$ipAddress:3800/selectTime/registertime');

    try {
      final Map<dynamic, dynamic> data = {
        "email": email,
        "startTime": startTime,
        "endTime": endTime,
        "amount": amount,
        "date": date,
      };
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('success');
        print(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (!day.isBefore(DateTime.now())) {
      setState(() {
        today = day;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? startTime ?? TimeOfDay.now()
          : endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      DateTime selectedDateTime = DateTime(
        today.year,
        today.month,
        today.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDateTime.isBefore(DateTime.now())) {
        // Show error dialog for past time selection
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Cannot select a time before the current time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Exit the method if the selected time is before the current time
      }

      if (!isStartTime &&
          (picked.hour < (startTime?.hour ?? 0) ||
              (picked.hour == (startTime?.hour ?? 0) &&
                  picked.minute < (startTime?.minute ?? 0)))) {
        // Show error dialog for end time before start time
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('End time cannot be before start time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Exit the method if end time is before start time
      }

      // Check if difference between start time and end time is greater than 1 hour
      if (!isStartTime) {
        DateTime startDateTime = DateTime(
          today.year,
          today.month,
          today.day,
          startTime!.hour,
          startTime!.minute,
        );

        if (selectedDateTime.difference(startDateTime).inHours < 1) {
          // Show error dialog for difference less than 1 hour
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Difference between start time and end time must be greater than 1 hour.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
          return; // Exit the method if difference is less than 1 hour
        }
      }

      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  bool isTimeSelected() {
    return startTime != null && endTime != null;
  }

  int price() {
    int hours = (endTime?.hour ?? 0) - (startTime?.hour ?? 0);
    int minutes = (endTime?.minute ?? 0) - (startTime?.minute ?? 0);
    double totalHours = hours + minutes / 60.0;
    return (totalHours * perHourRate).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(25, 7, 25, 0),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    'Select Time Slot',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Content(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("Selected Day = " + today.toString().split(" ")[0]),
          Text(" "),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 12),
              onDaySelected: _onDaySelected,
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.blueAccent,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Start Time', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, true),
                        child:
                            Text('${startTime?.format(context) ?? "Select"}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('End Time', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, false),
                        child: Text('${endTime?.format(context) ?? "Select"}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 4,
            color: Colors.blueAccent,
            height: 20,
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Per Hour Rate', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Rs $perHourRate',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Amount: Rs ${price()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: isTimeSelected()
                ? () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              
                    selectTime(
                      startTime!.format(context),
                      endTime!.format(context),
                      price().toString(),
                      today.toString().split(" ")[0],

                    );
                    Navigator.pushNamed(context, '/payment_page',
                        arguments: {'price': price()});
                  }
                : null,
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}
