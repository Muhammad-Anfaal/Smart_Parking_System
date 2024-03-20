import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final ManageSubscription subscription;

  User({
    required this.id,
    required this.name,
    required this.subscription,
  });
}

class ManageSubscription {
  final int id;
  final String duration;
  final DateTime fromDate;
  final DateTime toDate;
  final int price;

  ManageSubscription({
    required this.id,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.price,
  });
}

class ManageSubscriptions extends StatefulWidget {
  const ManageSubscriptions({Key? key}) : super(key: key);

  @override
  State<ManageSubscriptions> createState() => _ManageSubscriptionsState();
}

class _ManageSubscriptionsState extends State<ManageSubscriptions> {
  final List<User> users = [
    User(
      id: 1,
      name: 'User 1',
      subscription: ManageSubscription(
        id: 1,
        duration: '1 Month',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(Duration(days: 30)),
        price: 1000,
      ),
    ),
    User(
      id: 2,
      name: 'User 2',
      subscription: ManageSubscription(
        id: 2,
        duration: '2 Months',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(Duration(days: 60)),
        price: 2000,
      ),
    ),
    User(
      id: 3,
      name: 'User 3',
      subscription: ManageSubscription(
        id: 3,
        duration: '3 Months',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(Duration(days: 90)),
        price: 3000,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Subscriptions'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white10,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserCard(
            user: user,
            onDelete: () {
              _showConfirmationDialog(user, index);
            },
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(User user, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this subscription?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Subscription deleted successfully'),
                    backgroundColor: Colors.green, // Set background color to green
                  ),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;

  UserCard({required this.user, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.black38],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            'User: ${user.name}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription: ${user.subscription.duration}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Price: ${user.subscription.price} PKR',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'From: ${user.subscription.fromDate.toString().substring(0, 16)}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'To: ${user.subscription.toDate.toString().substring(0, 16)}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          trailing: Container(
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orangeAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: onDelete,
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
