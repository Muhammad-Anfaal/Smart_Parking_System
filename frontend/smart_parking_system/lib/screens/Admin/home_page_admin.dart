import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageAdmin extends StatefulWidget {
  const MyHomePageAdmin({Key? key});

  @override
  State<MyHomePageAdmin> createState() => _MyHomePageAdminState();
}

class _MyHomePageAdminState extends State<MyHomePageAdmin> {
  String _greeting = '';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
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
                        'Hello Admin!',
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
                      trailing: IconButton(
                        icon: Icon(Icons.exit_to_app), // Log-out icon
                        color: Colors.white,
                        onPressed: () {
                          // Log out functionality
                          _logOut();
                        },
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              Container(
                color: Colors.red,
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
                      itemDashboard('Approve Area',
                          CupertinoIcons.map_pin_ellipse, Colors.blueGrey, () {
                            Navigator.pushNamed(context, '/approve_area');
                          }),
                      itemDashboard('Statistics',
                          CupertinoIcons.chart_bar_square, Colors.green, () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(context, '/register_parking_area');
                          }),
                      itemDashboard('Manage Subscriptions',
                          CupertinoIcons.person_2_alt, Colors.blue, () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(
                                context, '/manage_subscriptions');
                          }),
                      itemDashboard('Parking Areas', CupertinoIcons.map_fill,
                          Colors.orange, () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(
                                context, '/manage_parking_area');
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

  Widget itemDashboard(
      String title, IconData iconData, Color background, VoidCallback onTap) =>
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
    Navigator.pushNamedAndRemoveUntil(context, '/log_in', (route) => false);
  }
}
