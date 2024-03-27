import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ParkingRegistration extends StatefulWidget {
  const ParkingRegistration();

  @override
  State<ParkingRegistration> createState() => _ParkingRegistrationState();
}

class _ParkingRegistrationState extends State<ParkingRegistration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _registrationController = TextEditingController();
  TextEditingController _carColorController = TextEditingController();
  TextEditingController _carStateController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  List<Map<String, String>> _registeredCars = [];

  @override
  void initState() {
    super.initState();
    _loadRegisteredCars();
  }

  // Load registered cars from SharedPreferences
  Future<void> _loadRegisteredCars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? carsJson = prefs.getStringList('registered_cars');
    if (carsJson != null) {
      setState(() {
        _registeredCars = carsJson
            .map((carJson) => Map<String, String>.from(jsonDecode(carJson)))
            .toList();
      });
    }
  }

  // Save registered cars to SharedPreferences
  Future<void> _saveRegisteredCars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> carsJson =
        _registeredCars.map((car) => jsonEncode(car)).toList();
    await prefs.setStringList('registered_cars', carsJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Show input fields if less than 3 cars registered
                      Visibility(
                        visible: _registeredCars.length < 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _registrationController,
                              decoration: InputDecoration(
                                  labelText: 'Car Registration Number',
                                  labelStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter car registration number';
                                }
                                if (!RegExp(r'^[A-Z]{2,3}-\d{1,4}$')
                                    .hasMatch(value)) {
                                  return 'Invalid car registration number. Format should be XXX-1 to XXX-XXXX';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _carStateController,
                              decoration: InputDecoration(
                                  labelText: 'Car State',
                                  labelStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter car state';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _carModelController,
                              decoration: InputDecoration(
                                  labelText: 'Car Model',
                                  labelStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter car model';
                                }
                                int model;
                                try {
                                  model = int.parse(value);
                                } catch (e) {
                                  return 'Please enter a valid integer for car model';
                                }
                                if (model > 2024) {
                                  return 'Car model should not be greater than 2024';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _carColorController,
                              decoration: InputDecoration(
                                  labelText: 'Car Color',
                                  labelStyle: TextStyle(color: Colors.black)),
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter car color';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      // Register Car button
                      ElevatedButton(
                        onPressed: () {
                          if (_registeredCars.length < 3) {
                            if (_formKey.currentState!.validate()) {
                              _registerCar();
                            }
                          }
                        },
                        child: Text('Register Car',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      ),
                      SizedBox(height: 20),
                      // Display registered cars
                      Text(
                        'Registered Cars:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _registeredCars.length,
                        itemBuilder: (context, index) {
                          final car = _registeredCars[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text('Car ${index + 1}',
                                    style: TextStyle(color: Colors.black)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Registration Number: ${car['registration']}',
                                        style: TextStyle(color: Colors.black)),
                                    Text('Car State: ${car['carState']}',
                                        style: TextStyle(color: Colors.black)),
                                    Text('Car Model: ${car['carModel']}',
                                        style: TextStyle(color: Colors.black)),
                                    Text('Color: ${car['color']}',
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _deleteCar(index);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registerCar() {
    String registrationNumber = _registrationController.text;
    bool isDuplicate =
        _registeredCars.any((car) => car['registration'] == registrationNumber);

    if (isDuplicate) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Registration number already exists',
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      );

      return;
    }

    _registeredCars.add({
      'registration': _registrationController.text,
      'carState': _carStateController.text,
      'carModel': _carModelController.text,
      'color': _carColorController.text,
    });

    // Clear input field controllers
    _registrationController.clear();
    _carStateController.clear();
    _carModelController.clear();
    _carColorController.clear();

    // Save registered cars to SharedPreferences
    _saveRegisteredCars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Car registered successfully'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {});
  }

  void _deleteCar(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Car'),
          content: Text('Are you sure you want to delete this car?'),
          actions: [
            TextButton(
              onPressed: () {
                _registeredCars.removeAt(index);
                // Save registered cars to SharedPreferences after deleting
                _saveRegisteredCars();
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _registrationController.dispose();
    _carColorController.dispose();
    _carStateController.dispose();
    _carModelController.dispose();
    super.dispose();
  }
}
