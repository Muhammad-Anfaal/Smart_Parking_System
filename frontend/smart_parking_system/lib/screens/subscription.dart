import 'package:flutter/material.dart';
import 'payment_page.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove app bar elevation
        title: Text(''), // Remove app bar title
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Set width of the main container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Subscription',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SubscriptionGroupCard(
                  subscriptions: [
                    SubscriptionCard(duration: '1 Month', price: 1000, color: Colors.green, onTap: () {
                      setState(() {
                        fromDate = DateTime.now();
                        toDate = DateTime.now().add(Duration(days: 30));
                      });
                    }),
                    SubscriptionCard(duration: '2 Months', price: 2000, color: Colors.orange, onTap: () {
                      setState(() {
                        fromDate = DateTime.now();
                        toDate = DateTime.now().add(Duration(days: 60));
                      });
                    }),
                    SubscriptionCard(duration: '3 Months', price: 3000, color: Colors.red, onTap: () {
                      setState(() {
                        fromDate = DateTime.now();
                        toDate = DateTime.now().add(Duration(days: 90));
                      });
                    }),
                  ],
                ),
                SizedBox(height: 20),
                if (fromDate != null && toDate != null)
                  PaymentCard(fromDate: fromDate!, toDate: toDate!, price: 1000), // Pass the price here
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

  SubscriptionCard({required this.duration, required this.price, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: SizedBox(
        height: 80, // Set the height of the ListTile
        child: ListTile(
          title: Text('$duration Subscription', style: TextStyle(color: Colors.white)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Expanded(
                child: Text(
                  '$price PKR',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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

  PaymentCard({required this.fromDate, required this.toDate, required this.price});

  @override
  Widget build(BuildContext context) {
    int durationInMonths = toDate.month - fromDate.month + 12 * (toDate.year - fromDate.year);

    return Card(
      color: Colors.blue,
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
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      '$durationInMonths months',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                // Navigate to the payment page and pass subscription details as arguments
                Navigator.pushNamed(
                  context,
                  '/payment_page',
                  arguments: {
                    'price': price,
                    'fromDate': fromDate,
                    'toDate': toDate,
                    'durationInMonths': durationInMonths,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('Proceed to Payment', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
