import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as ffv;
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

Future<void> signUpUser(
    String name,
    String email,
    String pass,
    String cnic,
    String city,
    String address,
    String phone,
    String userType,
    String? imagePath) async {
  // String ipAddress = '10.0.2.2'; // for emulator
  String ipAddress = '127.0.0.1'; // for browser
  final url = Uri.parse('http://$ipAddress:3000/user/createusers');

  try {
    final Map<dynamic, dynamic> data = {
      "userName": name,
      "userEmail": email,
      "userPhoneNumber": phone,
      "userCity": city,
      "userCNIC": cnic,
      "userAddress": address,
      "userPassword": pass,
      "userType": userType,
      "userImage": imagePath ?? ""
    };
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('success');
      print(response.body);
    }
  } catch (e) {
    print('Error: $e');
  }
}

void sendEmail(String email, int otp) async {
  String username = 'smartparkingsyst3m.sps@gmail.com';
  String password = 'ypxs gtlt qrds bcfa';

  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username, 'SpS')
    ..recipients.add(email)
    ..subject = 'Your OTP'
    ..html = "<h1>OTP</h1>\n<p>$otp</p>";

  try {
    send(message, smtpServer);
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  var connection = PersistentConnection(smtpServer);
  await connection.send(message);
  await connection.close();
}

class SignUpPage extends StatefulWidget {
  final String userType;

  const SignUpPage({super.key, required this.userType});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  int otp = 0;
  XFile? _imageFile; // Variable to store the selected image file

  final _formKey = GlobalKey<FormState>();

  bool _signup() {
    final checkValid = _formKey.currentState?.validate();
    if (!checkValid!) {
      return false;
    }
    _formKey.currentState?.save();
    return true;
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final nameValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'name is required'),
    ffv.MaxLengthValidator(30,
        errorText: 'name must be less than 30 characters'),
    ffv.MinLengthValidator(3,
        errorText: 'name must be greater than 3 characters'),
    ffv.PatternValidator(r'^[a-zA-Z\s]+$',
        errorText: 'name must be consists of only alphabets'),
  ]);

  final emailValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'email is required'),
    ffv.EmailValidator(errorText: 'email is not valid'),
  ]);

  final phoneValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'mobile number is required'),
    ffv.PatternValidator(r'^[0-9]+$', errorText: 'Only numbers allowed'),
    ffv.MaxLengthValidator(11, errorText: 'mobile number must be of 11 digits'),
    ffv.MinLengthValidator(11, errorText: 'mobile number must be of 11 digits'),
  ]);

  final cityValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'city is required'),
    ffv.MaxLengthValidator(30,
        errorText: 'city must be less than 30 characters'),
    ffv.MinLengthValidator(3,
        errorText: 'city must be greater than 3 characters'),
    ffv.PatternValidator(r'^[a-zA-Z\s]+$',
        errorText: 'city must be consists of only alphabets'),
  ]);

  final cnicValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'cnic is required'),
    ffv.PatternValidator(r'^[0-9]+$', errorText: 'Only numbers allowed'),
    ffv.MaxLengthValidator(13, errorText: 'cnic must be of 13 digits'),
    ffv.MinLengthValidator(13, errorText: 'cnic must be of 13 digits'),
  ]);

  final addressValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'address is required'),
    ffv.MinLengthValidator(20,
        errorText: 'address must be greater than 20 characters'),
  ]);

  final passwordValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'password is required'),
    ffv.MinLengthValidator(8, errorText: 'password must have 8 characters'),
    ffv.PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must contain one special character'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text('Register your account'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputField(
                        text: 'Name',
                        icon: Icons.account_circle,
                        textType: TextInputType.name,
                        controller: name,
                        validator: nameValidator,
                      ),
                      InputField(
                        text: 'Email address',
                        icon: Icons.mail,
                        textType: TextInputType.emailAddress,
                        controller: email,
                        validator: emailValidator,
                      ),
                      InputField(
                        text: 'Mobile No.',
                        icon: Icons.phone,
                        textType: TextInputType.phone,
                        controller: phone,
                        validator: phoneValidator,
                      ),
                      InputField(
                        text: 'City',
                        icon: Icons.location_city,
                        textType: TextInputType.text,
                        controller: city,
                        validator: cityValidator,
                      ),
                      InputField(
                        text: 'CNIC',
                        icon: Icons.remember_me,
                        textType: TextInputType.number,
                        controller: cnic,
                        validator: cnicValidator,
                      ),
                      InputField(
                        text: 'Address',
                        icon: Icons.home,
                        textType: TextInputType.text,
                        controller: address,
                        validator: addressValidator,
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickImage(); // Call image picker when tapped
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: _imageFile == null
                                  ? Icon(Icons.add_a_photo)
                                  : Image.file(File(_imageFile!.path)),
                            ),
                            SizedBox(height: 8),
                            // Add spacing between text and image container
                            Text(
                              'Insert your profile image',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextFormField(
                          validator: passwordValidator,
                          controller: password,
                          keyboardType: TextInputType.text,
                          obscureText: hidePassword,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.lightBlue[900]),
                            icon: const Icon(Icons.lock_open),
                            iconColor: Colors.lightBlue[900],
                            suffixIconColor: Colors.lightBlue[900],
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextFormField(
                          validator: (val) => ffv.MatchValidator(
                                  errorText: 'password does not match')
                              .validateMatch(val!, password.text),
                          controller: confirmPassword,
                          keyboardType: TextInputType.text,
                          obscureText: hideConfirmPassword,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              icon: Icon(
                                hideConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.lightBlue[900]),
                            icon: const Icon(Icons.lock_open),
                            iconColor: Colors.lightBlue[900],
                            suffixIconColor: Colors.lightBlue[900],
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 20.0,
                          ),
                          backgroundColor: Colors.blue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        onPressed: () {
                          if (_signup() == true) {
                            otp = Random().nextInt(1000000) + 100000;
                            print(
                                '*******************************************************************OTP is: $otp*******************************************************************');
                            print(
                                '*******************************************************************UserType is: ${widget.userType}*******************************************************************');
                            sendEmail(email.text, otp);
                            final result = Navigator.pushNamed(
                                context, '/pin_code', arguments: {
                              'userType': widget.userType,
                              'otp': otp.toString()
                            });
                            result.then((value) {
                              if (value == 'success') {
                                signUpUser(
                                  name.text,
                                  email.text,
                                  password.text,
                                  cnic.text,
                                  city.text,
                                  address.text,
                                  phone.text,
                                  widget.userType,
                                  _imageFile?.path, // Pass image path
                                );
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[900],
                          ),
                        ),
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

  // Function to handle image picking
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
        final bytes = _imageFile!.readAsBytes();
        print(_imageFile!);
      });
    }
  }
}

class InputField extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextInputType textType;
  final TextEditingController controller;
  final ffv.MultiValidator validator;

  const InputField({
    required this.text,
    required this.icon,
    required this.textType,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.lightBlue[900]),
          icon: Icon(icon),
          iconColor: Colors.lightBlue[900],
          suffixIconColor: Colors.lightBlue[900],
          border: InputBorder.none,
        ),
      ),
    );
  }
}
