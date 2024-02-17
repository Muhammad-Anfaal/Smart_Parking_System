import 'package:flutter/material.dart';

class ParkingRegistration extends StatefulWidget {
  const ParkingRegistration();

  @override
  State<ParkingRegistration> createState() => _ParkingRegistrationState();
}

class _ParkingRegistrationState extends State<ParkingRegistration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _registrationController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _carColorController = TextEditingController();
  TextEditingController _carStateController = TextEditingController(); // New controller for car state
  List<Map<String, String>> _registeredCars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _registrationController,
                    decoration: InputDecoration(labelText: 'Car Registration Number', labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter car registration number';
                      }
                      // Validation using regular expression
                      if (!RegExp(r'^[A-Z]{2,3}-\d{2,3}-\d{1,4}$').hasMatch(value)) {
                        return 'Invalid car registration number. Format should be XXX-XX-XXXX';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: InputDecoration(labelText: 'Car Owner Name', labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter car owner name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _carStateController,
                    decoration: InputDecoration(labelText: 'Car State', labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _carColorController,
                    decoration: InputDecoration(labelText: 'Car Color', labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter car color';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Register the car
                        _registerCar();
                      }
                    },
                    child: Text('Register Car', style: TextStyle(color: Colors.blue)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Registered Cars:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _registeredCars.length,
                      itemBuilder: (context, index) {
                        final car = _registeredCars[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text('Car ${index + 1}', style: TextStyle(color: Colors.black)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Registration Number: ${car['registration']}', style: TextStyle(color: Colors.black)),
                                Text('Owner Name: ${car['ownerName']}', style: TextStyle(color: Colors.black)),
                                Text('Car State: ${car['carState']}', style: TextStyle(color: Colors.black)), // Display car state
                                Text('Color: ${car['color']}', style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registerCar() {
    // Check if maximum limit of 3 cars is reached
    if (_registeredCars.length >= 3) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Maximum Limit Reached'),
            content: Text('You have already registered 3 cars.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    String registrationNumber = _registrationController.text;
    bool isDuplicate = _registeredCars.any((car) => car['registration'] == registrationNumber);

    if (isDuplicate) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Registration number already exists', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      );
      return;
    }

    _registeredCars.add({
      'registration': _registrationController.text,
      'ownerName': _ownerNameController.text,
      'carState': _carStateController.text,
      'color': _carColorController.text,
    });

    _registrationController.clear();
    _ownerNameController.clear();
    _carStateController.clear();
    _carColorController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Car registered successfully'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {

    _registrationController.dispose();
    _ownerNameController.dispose();
    _carColorController.dispose();
    _carStateController.dispose();
    super.dispose();
  }
}
