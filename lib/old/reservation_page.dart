import 'package:flutter/material.dart';

class ParkingArea {
  final String imageName;
  final String parkingAreaName;
  final String capacity;

  ParkingArea(
      {required this.imageName,
      required this.parkingAreaName,
      required this.capacity});
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<ParkingArea> parkingAreas = [
    ParkingArea(
        imageName: 'assets/images/ghanta.jpeg',
        parkingAreaName: 'Place 1',
        capacity: 'Capacity: 50'),
    ParkingArea(
        imageName: 'assets/images/gumti.jpeg',
        parkingAreaName: 'Place 2',
        capacity: 'Capacity: 60'),
    ParkingArea(
        imageName: 'assets/images/darbar.jpeg',
        parkingAreaName: 'Place 3',
        capacity: 'Capacity: 70'),
    ParkingArea(
        imageName: 'assets/images/iqbal.jpeg',
        parkingAreaName: 'Place 4',
        capacity: 'Capacity: 80'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  'Select Parking Area',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: parkingAreas.length,
                itemBuilder: (context, index) {
                  return buildInteractiveContainer(
                    parkingAreas[index].imageName,
                    parkingAreas[index].parkingAreaName,
                    parkingAreas[index].capacity,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInteractiveContainer(
      String imageName, String parkingAreaName, String capacity) {
    return GestureDetector(
      onTap: () {
        // showSnackBar(context, 'You tapped $placeName');
        navigateToSelectTime();
      },
      child: Hero(
        tag: parkingAreaName,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  imageName,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                parkingAreaName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                capacity,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void navigateToSelectTime() {
    Navigator.pushNamed(context, '/select_time');
  }
}
