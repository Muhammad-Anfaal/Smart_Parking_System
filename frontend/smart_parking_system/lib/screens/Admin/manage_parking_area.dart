import 'package:flutter/material.dart';

class ManageParkingArea extends StatefulWidget {
  const ManageParkingArea({Key? key}) : super(key: key);

  @override
  State<ManageParkingArea> createState() => _ManageParkingAreaState();
}

class _ManageParkingAreaState extends State<ManageParkingArea> {
  late TextEditingController nameController;
  late TextEditingController capacityController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    capacityController = TextEditingController();
    locationController = TextEditingController();
  }

  void _changeLocationAndCapacity() {
    String newName = nameController.text;
    String newCapacity = capacityController.text;
    String newLocation = locationController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location and Capacity changed for $newName.'),
      ),
    );
  }

  void _deleteParkingArea() {
    String name = nameController.text;
    String location = locationController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Parking Area $name at $location deleted.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Parking Area"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Parking Area Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Capacity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: capacityController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeLocationAndCapacity,
              child: Text('Change Location & Capacity'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteParkingArea,
              child: Text('Delete Parking Area'),
            ),
          ],
        ),
      ),
    );
  }
}
