import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:form_field_validator/form_field_validator.dart' as ffv;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> loginUser(String email, String pass, String utype) async {
  // String ipAddress = '10.0.2.2'; // for emulator
  // String ipAddress = '127.0.0.1'; // for browser
  // String ipAddress = '10.20.16.37'; // laptop address HAHAHAHAHAHAHAHAHAHAHAHAHA
  // laptop address HAHAHAHAHAHAHAHAHAHAHAHAHA
  String ipAddress = '192.168.137.1'; // lan adapter ip address
  // String ipAddress = '192.168.18.14'; // wifi ip address

  final url = Uri.parse('http://$ipAddress:3000/user/validateuser');

  try {
    final Map<dynamic, dynamic> data = {
      "email": email,
      "password": pass,
      "utype": utype
    };
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setBool('isLoggedIn', true);
      prefs.setBool('profileImage', false);
      return true;
    }
  } catch (e) {
    print('Error: $e');
  }
  return false;
}

class LogInPage extends StatefulWidget {
  final String userType;

  LogInPage({Key? key, required this.userType}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  bool _login() {
    final checkValid = _formKey.currentState?.validate();
    if (checkValid == false) {
      return false;
    }
    _formKey.currentState?.save();
    return true;
  }

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  final emailValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'email is required'),
    ffv.EmailValidator(errorText: 'email is not valid'),
  ]);

  final passwordValidator = ffv.MultiValidator([
    ffv.RequiredValidator(errorText: 'password is required'),
    ffv.MinLengthValidator(8, errorText: 'password must have 8 characters'),
    ffv.PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must contain at least one special character'),
  ]);

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text('Smart Parking System'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue[700],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 75.0,
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 75.0,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextFormField(
                      validator: emailValidator,
                      controller: emailTextField,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle: TextStyle(color: Colors.lightBlue[900]),
                        icon: const Icon(Icons.mail),
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
                      validator: passwordValidator,
                      controller: passwordTextField,
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
                    onPressed: () async {
                      // test user
                      if (emailTextField.text == 'test' &&
                          passwordTextField.text == 'test') {
                        Navigator.pushNamed(
                            context, '/home_page_${widget.userType}',
                            arguments: {'userType': widget.userType});
                      }
                      if (_login() == true) {
                        if (await loginUser(emailTextField.text,
                                passwordTextField.text, widget.userType) ==
                            true) {
                          Navigator.pushNamed(
                              context, '/home_page_${widget.userType}',
                              arguments: {'userType': widget.userType});
                        } else {
                          Alert(
                            context: context,
                            title: '',
                            desc: 'Invalid Credentials.',
                          ).show();
                        }
                      }
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[900],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_up',
                                arguments: {'userType': widget.userType});
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                            ),
                          ),
                        ),
                      ],
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

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushNamed(context, '/home_page_${widget.userType}',
          arguments: {'userType': widget.userType});
    }
  }
}
