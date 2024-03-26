import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyHomePageOwner extends StatefulWidget {
  const MyHomePageOwner({super.key});

  @override
  State<MyHomePageOwner> createState() => _MyHomePageOwnerState();
}

class _MyHomePageOwnerState extends State<MyHomePageOwner> {
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
                        'Hello Awab!',
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
                      trailing: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/awab5.jpg'),
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
                      itemDashboard(
                          'Register Area', CupertinoIcons.map_fill, Colors.red,
                              () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(context, '/register_parking_area');
                          }),
                      itemDashboard(
                          'Extend Area', CupertinoIcons.arrow_up, Colors.orange,
                              () {
                            // Navigate to subscription page when item is clicked
                            Navigator.pushNamed(context, '/extend_area');
                          }),
                      SizedBox(height: 0.0),
                      SizedBox(height: 0.0),
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

  Widget itemDashboard(String title, IconData iconData, Color background,
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
}
