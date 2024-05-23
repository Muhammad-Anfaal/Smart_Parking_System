import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ExtendTime extends StatefulWidget {
  const ExtendTime({Key? key}) : super(key: key);

  @override
  State<ExtendTime> createState() => _ExtendTimeState();
}

class _ExtendTimeState extends State<ExtendTime> {
  late DateTime _startTime;
  late DateTime _endTime;
  bool _extensionConfirmed = false;
  bool _buttonsEnabled = true; // Track whether buttons should be enabled or not

  Future<void> extendTime(int amount, String endTime) async {
    String ipAddress = '192.168.137.1'; // lan adapter ip address
    final url = Uri.parse('http://$ipAddress:3800/selectTime/extendtime');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email')!;

    try {
      final Map<dynamic, dynamic> data = {
        "email": email,
        "endtime": endTime,
        "amount": amount,
      };

      print("***********************************************************8");
      print(endTime);
      print(amount);
      print(email);
      print("***********************************************************8");
      final response = await http.put(
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

  @override
  void initState() {
    super.initState();
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Set the start time to 7:00 PM on the current date
    _startTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 12, 0);

    // Set the end time to 11:00 PM on the current date
    _endTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 13, 0);
  }

  void _handleExtendTime(DateTime newEndTime, int price) {
    // Check if the current time is after the starting time
    if (DateTime.now().isAfter(_startTime)) {
      if (!_extensionConfirmed) {
        setState(() {
          _buttonsEnabled = false; // Disable buttons once any button is clicked
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Extension'),
            content: Text('Are you sure you want to extend the parking time?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _endTime = newEndTime;
                    _extensionConfirmed = true;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        );
      }
    } else {
      // Show message if starting time has not started yet
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Cannot Extend Time'),
          content: Text('The starting time has not started yet.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _resetPage() {
    setState(() {
      // Reset to default values
      _extensionConfirmed = false;
      _buttonsEnabled = true;
      // Reset to default time values (7:00 PM to 11:00 PM)
      DateTime currentDate = DateTime.now();
      _startTime =
          DateTime(currentDate.year, currentDate.month, currentDate.day, 18, 0);
      _endTime =
          DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extend Parking Time'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExtendTimePage(
              startTime: _startTime,
              endTime: _endTime,
              onExtendTime: _handleExtendTime,
              buttonsEnabled:
                  _buttonsEnabled, // Pass the state variable to the child widget
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _resetPage,
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ExtendTimePage extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final Function(DateTime, int) onExtendTime;
  final bool
      buttonsEnabled; // Receive the state variable indicating whether buttons should be enabled

  const ExtendTimePage({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.onExtendTime,
    required this.buttonsEnabled, // Receive the state variable
  }) : super(key: key);

  @override
  _ExtendTimePageState createState() => _ExtendTimePageState();
}

class _ExtendTimePageState extends State<ExtendTimePage> {
  late Timer _timer;
  late Duration _remainingTime;
  int _price = 0;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.endTime.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.endTime.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateAmount(Duration extensionDuration) {
    int hours = extensionDuration.inHours;
    int minutes = extensionDuration.inMinutes.remainder(60);
    _price = (hours * 50) + (minutes > 0 ? 50 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Remaining Time:',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '${_remainingTime.inHours}h ${_remainingTime.inMinutes.remainder(60)}m ${_remainingTime.inSeconds.remainder(60)}s',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Select Time Extension:',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: widget.buttonsEnabled
                      ? () {
                          Duration extensionDuration = Duration(minutes: 30);
                          _calculateAmount(extensionDuration);
                          widget.onExtendTime(
                              widget.endTime.add(extensionDuration), _price);
                        }
                      : null, // Disable button if buttons are not enabled
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('+30 minutes', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: widget.buttonsEnabled
                      ? () {
                          Duration extensionDuration = Duration(hours: 1);
                          _calculateAmount(extensionDuration);
                          widget.onExtendTime(
                              widget.endTime.add(extensionDuration), _price);
                        }
                      : null, // Disable button if buttons are not enabled
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('+1 hour', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: widget.buttonsEnabled
                      ? () {
                          Duration extensionDuration = Duration(hours: 2);
                          _calculateAmount(extensionDuration);
                          widget.onExtendTime(
                              widget.endTime.add(extensionDuration), _price);
                        }
                      : null, // Disable button if buttons are not enabled
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('+2 hours', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount:',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Rs $_price',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment_page',
                      arguments: {'price': _price});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Pay', style: TextStyle(fontSize: 18.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
