import 'package:flutter/material.dart';

class SelectModule extends StatelessWidget {
  const SelectModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Parking System"),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Spacer(),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.blue[300],
                ),
                child: SizedBox(
                  width: 350, // Adjust the width as needed for the card
                  height: 350, // Adjust the height as needed for the card
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Add image from assets
                      Image.asset(
                        'assets/images/logo.png', // Update the path accordingly
                        width: 130,
                        height: 130,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/log_in',
                                  arguments: {'userType': 'user'});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 29.0,
                              ),
                              backgroundColor: Colors.blue[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: const Text(
                              'User',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/log_in',
                                  arguments: {'userType': 'owner'});
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 20.0,
                              ),
                              backgroundColor: Colors.blue[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: const Text(
                              'Owner',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
