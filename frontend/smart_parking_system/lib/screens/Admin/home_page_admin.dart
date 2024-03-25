import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyHomePageAdmin extends StatefulWidget {
  const MyHomePageAdmin({super.key});

  @override
  State<MyHomePageAdmin> createState() => _MyHomePageAdminState();
}

class _MyHomePageAdminState extends State<MyHomePageAdmin> {
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
                        'Good Morning',
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
                        Navigator.pushNamed(context, '/manage_subscriptions');
                      }),
                      itemDashboard('Parking Areas', CupertinoIcons.map_fill,
                          Colors.orange, () {
                        // Navigate to subscription page when item is clicked
                        Navigator.pushNamed(context, '/manage_parking_area');
                      }),
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
      String title, IconData iconData, Color background, VoidCallback onTap) {
    return GestureDetector(
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
            Center(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
