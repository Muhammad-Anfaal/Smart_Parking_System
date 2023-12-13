import 'package:flutter/material.dart';

class SelectModule extends StatelessWidget {
  const SelectModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Smart Parking System")),
        backgroundColor: Colors.lightBlue,
        body: Column(
          children: <Widget>[
            Spacer(),
            SelecModule(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SelecModule extends StatelessWidget {
  const SelecModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 350, // Adjust the width as needed for the card
          height: 250, // Adjust the height as needed for the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Add image from assets
              Image.asset(
                'assets/images/logo.png', // Update the path accordingly
                width: 100, // Adjust the width as needed for the image
                height: 75, // Adjust the height as needed for the image
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: Text("Login as User"),
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: Text("Login as Owner"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
