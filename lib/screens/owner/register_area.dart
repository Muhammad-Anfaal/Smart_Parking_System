import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const CardExamples());
}

class CardExamples extends StatelessWidget {
  const CardExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff483481),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
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
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
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
  late TextEditingController nameController;
  late TextEditingController capacityController;
  late TextEditingController locationController;
  late String imagePath;

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
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          color: Colors.lightBlue,
          child: SizedBox(
            width: 350,
            height: imagePath.isNotEmpty ? 500 : 400,
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
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Choose Image'),
                ),
                SizedBox(height: 10),
                if (imagePath.isNotEmpty)
                  Image.network(
                    imagePath,
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add your submit logic here
                    // You can access the entered values using:
                    // nameController.text, capacityController.text, locationController.text
                    // and imagePath for the selected image path.
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
