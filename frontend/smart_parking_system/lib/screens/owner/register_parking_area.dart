import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterParkingArea extends StatelessWidget {
  const RegisterParkingArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff483481),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Register Parking Area",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: ElevatedCardExample(),
        ),
      ),
    );
  }
}

class ElevatedCardExample extends StatefulWidget {
  const ElevatedCardExample({Key? key}) : super(key: key);

  @override
  _ElevatedCardExampleState createState() => _ElevatedCardExampleState();
}

class _ElevatedCardExampleState extends State<ElevatedCardExample> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController capacityController;
  late TextEditingController locationController;
  late String imagePath;
  String? nameError;
  String? capacityError;
  String? locationError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    capacityController = TextEditingController();
    locationController = TextEditingController();
    imagePath = '';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      print(imageBytes);

      setState(() {
        imagePath = pickedFile.path;
        print(pickedFile.path);
      });
    }
  }

  void _validateAndSubmit() {
    setState(() {
      nameError = _nameValidator(nameController.text);
      capacityError = _capacityValidator(capacityController.text);
      locationError = _locationValidator(locationController.text);
    });

    if (nameError == null && capacityError == null && locationError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wait for approval'),
        ),
      );
    }
  }

  String? _nameValidator(String value) {
    if (value.isEmpty) {
      return 'Parking Area Name is required';
    }
    return null;
  }

  String? _capacityValidator(String value) {
    if (value.isEmpty) {
      return 'Capacity is required';
    }
    final capacity = int.tryParse(value);
    if (capacity == null) {
      return 'Invalid capacity';
    }
    return null;
  }

  String? _locationValidator(String value) {
    if (value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        color: Colors.lightBlue,
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.85,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Align(
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                if (nameError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      nameError!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                const Align(
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: capacityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                if (capacityError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      capacityError!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                const Align(
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                if (locationError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      locationError!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Image'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 20),
                if (imagePath.isNotEmpty)
                  Image.file(
                    File(imagePath),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.75,
                    fit: BoxFit.cover,

                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(RegisterParkingArea());
}
