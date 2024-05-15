import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart';
import 'package:http/http.dart' as http;

bool flag = true;

Future<void> loadData(String subscriptionType) async {
  String ipAddress = '192.168.137.1'; // lan adapter ip address
  final url = Uri.parse('http://$ipAddress:3800/subscription/create');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email')!;

  try {
    print("saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(email);
    print(subscriptionType);
    final Map<dynamic, dynamic> data = {
      "email": email,
      "subscriptionType": subscriptionType,
    };
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      flag = true;
      print('success');
      print(response.body);
    } else {
      flag = false;
    }
  } catch (e) {
    print('Error: $e');
  }
}

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  DateTime? fromDate;
  DateTime? toDate;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Rounded corners
          ),
        ),
        title: Text(
          'Subscription',
          style: TextStyle(color: Colors.white), // White text color
        ),
        iconTheme:
            IconThemeData(color: Colors.white), // Change back arrow color
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                SubscriptionGroupCard(
                  subscriptions: [
                    SubscriptionCard(
                        duration: '1 Month',
                        price: 1000,
                        color: Colors.green,
                        onTap: () {
                          setState(() {
                            fromDate = DateTime.now();
                            toDate = DateTime.now().add(Duration(days: 30));
                            selectedColor = Colors.green;
                          });
                        }),
                    SubscriptionCard(
                        duration: '2 Months',
                        price: 2000,
                        color: Colors.orange,
                        onTap: () {
                          setState(() {
                            fromDate = DateTime.now();
                            toDate = DateTime.now().add(Duration(days: 60));
                            selectedColor = Colors.orange;
                          });
                        }),
                    SubscriptionCard(
                        duration: '3 Months',
                        price: 3000,
                        color: Colors.red,
                        onTap: () {
                          setState(() {
                            fromDate = DateTime.now();
                            toDate = DateTime.now().add(Duration(days: 90));
                            selectedColor = Colors.red;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20),
                if (fromDate != null && toDate != null)
                  PaymentCard(
                      fromDate: fromDate!,
                      toDate: toDate!,
                      price: 1000,
                      color: selectedColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionGroupCard extends StatelessWidget {
  final List<Widget> subscriptions;

  SubscriptionGroupCard({required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose Subscription Duration',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: subscriptions,
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String duration;
  final int price;
  final Color color;
  final VoidCallback onTap;

  SubscriptionCard(
      {required this.duration,
      required this.price,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: SizedBox(
        height: 80,
        child: ListTile(
          title: Text('$duration Subscription',
              style: TextStyle(color: Colors.white)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              Expanded(
                child: Text(
                  '$price PKR',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final DateTime fromDate;
  final DateTime toDate;
  final int price;
  final Color? color;

  PaymentCard(
      {required this.fromDate,
      required this.toDate,
      required this.price,
      this.color});

  @override
  Widget build(BuildContext context) {
    int durationInMonths =
        toDate.month - fromDate.month + 12 * (toDate.year - fromDate.year);

    return Card(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Subscription Details',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From: ${fromDate.toString().substring(0, 16)}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'To: ${toDate.toString().substring(0, 16)}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      '$durationInMonths months',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                loadData('$durationInMonths months');
                if (flag) {
                  Navigator.pushNamed(
                    context,
                    '/payment_page',
                    arguments: {
                      'price': price,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User has already subscribed'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text('Proceed to Payment',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
