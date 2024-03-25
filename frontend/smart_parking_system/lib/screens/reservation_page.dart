import 'package:flutter/material.dart';

String ipAddress = '127.0.0.1'; // for browser
final url = Uri.parse('http://$ipAddress:3000/user/');

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
      imageName: 'assets/images/paris.jpg',
      parkingAreaName: 'Parking Area 1',
      capacity: 'Capacity: 50',
    ),
    ParkingArea(
      imageName: 'assets/images/iqbal.jpeg',
      parkingAreaName: 'Parking Area 2',
      capacity: 'Capacity: 75',
    ),
    ParkingArea(
      imageName: 'assets/images/gumti.jpeg',
      parkingAreaName: 'Parking Area 3',
      capacity: 'Capacity: 60',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(25, 7, 25, 0),
              child: AppBar(
                centerTitle: true,
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: parkingAreas.length,
                itemBuilder: (context, index) {
                  return ElevatedCardExample(
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

  Widget ElevatedCardExample(
      String imageName, String parkingAreaName, String capacity) {
    return GestureDetector(
      onTap: () {
        // Navigate to the select time page when the card is tapped
        navigateToSelectTime();
      },
      child: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(imageName),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parkingAreaName,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        capacity,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
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

  void navigateToSelectTime() {
    Navigator.pushNamed(context, '/select_time');
  }
}
