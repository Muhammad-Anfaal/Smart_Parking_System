import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageUser extends StatefulWidget {
  const MyHomePageUser({Key? key});

  @override
  State<MyHomePageUser> createState() => _MyHomePageUserState();
}

class _MyHomePageUserState extends State<MyHomePageUser> {
  String _greeting = '';
  String userName = '';
  Uint8List? img;

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email')!;

    String ipAddress = '192.168.137.1'; // lan adapter ip address
    final url = Uri.parse('http://$ipAddress:3800/user/users/$email');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      setState(() {
        userName = data['userName'];
        img = Uint8List.fromList(List<int>.from(data['userImage']['data']));
      });
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  void initState() {
    super.initState();
    _updateGreeting();
  }

  void _updateGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    setState(() {
      if (hour >= 6 && hour < 12) {
        _greeting = 'Good Morning';
      } else if (hour >= 12 && hour < 18) {
        _greeting = 'Good Afternoon';
      } else {
        _greeting = 'Good Night';
      }
      loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Text(
                        'Hello $userName!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        _greeting,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.exit_to_app), // Log-out icon
                            color: Colors.white,
                            onPressed: () {
                              // Log out functionality
                              _logOut();
                            },
                          ),
                          img != null
                              ? ClipOval(
                                  child: Image.memory(
                                    img!,
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                )
                              : Text('No image selected'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              Container(
                color: Colors.blue[700],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: [
                      itemDashboard('Reserve Slot', CupertinoIcons.calendar,
                          Colors.deepOrange, () {
                        // Navigate to ReservationPage when item is clicked
                        Navigator.pushNamed(context, '/reservation_page');
                      }),
                      itemDashboard('Subscription', CupertinoIcons.person_2_alt,
                          Colors.brown, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/subscription');
                      }),
                      itemDashboard(
                          'Extend Time', CupertinoIcons.clock, Colors.green,
                          () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/extend_time');
                      }),
                      itemDashboard('Car Details', CupertinoIcons.car_detailed,
                          Colors.indigo, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/car_registration');
                      }),
                      itemDashboard(
                          'Feedback', CupertinoIcons.mail_solid, Colors.purple,
                          () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/feedback_page');
                      }),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                      const SizedBox(height: 0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background,
          VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );

  // Log-out functionality
  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    // Navigate to the login page or any other initial page
    Navigator.pushNamedAndRemoveUntil(
        context, '/select_module', (route) => false);
  }
}
