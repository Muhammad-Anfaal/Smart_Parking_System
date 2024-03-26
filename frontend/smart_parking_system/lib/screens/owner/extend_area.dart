import 'package:flutter/material.dart';

class ExtendArea extends StatefulWidget {
  const ExtendArea({Key? key}) : super(key: key);

  @override
  State<ExtendArea> createState() => _ExtendAreaState();
}

class _ExtendAreaState extends State<ExtendArea> {
  late TextEditingController _parkingAreaController;
  late TextEditingController _capacityController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _parkingAreaController = TextEditingController();
    _capacityController = TextEditingController();
  }

  @override
  void dispose() {
    _parkingAreaController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          'Extend Parking Area',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      backgroundColor: Colors.blue, // Set background color to blue
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          color: Colors.white, // Change card color to white
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _parkingAreaController,
                    decoration: InputDecoration(
                      labelText: 'Parking Area Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parking area name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _capacityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Update Capacity',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter capacity';
                      }
                      final capacity = int.tryParse(value);
                      if (capacity == null || capacity <= 0) {
                        return 'Please enter a valid positive integer';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If form is valid, show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Submission'),
                                content: Text('Are you sure you want to submit?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Show snackbar
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Submitted successfully!'),
                                        ),
                                      );
                                      // Proceed with submit logic
                                      String parkingAreaName = _parkingAreaController.text;
                                      int newCapacity = int.parse(_capacityController.text);
                                      // Call your function to handle extending capacity with parkingAreaName and newCapacity
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Submit'),
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
}
