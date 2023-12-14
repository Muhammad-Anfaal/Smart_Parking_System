import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> loginUser() async {
  final url = Uri.parse('http://localhost:3300/users');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response as needed
      Map<String, dynamic> data = json.decode(response.body);
      print('Login successful');
      print('Response: ${response.body}');
      print(data['useremail']);
    } else {
      // Request failed, handle the error
      print('Failed to log in. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error: $e');
  }
}

class LogInPage extends StatefulWidget {
  final String userType;

  const LogInPage({super.key, required this.userType});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool hidePassword = true;
  bool otpCorrect = true;

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  TextEditingController otp = TextEditingController();

  List<List<String>> data = [
    ['abd', '123'],
  ];
  // data.add([emailTextField.text, passwordTextField.text]);

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text('Smart Parking System'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Image.asset('assets/images/logo.png'),
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
                child: TextField(
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
                child: TextField(
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
                        hidePassword ? Icons.visibility_off : Icons.visibility,
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
                  // loginUser('exception');
                  if (data[0][0] == emailTextField.text &&
                      data[0][1] == passwordTextField.text) {
                    loginUser();
                    // Alert(
                    //     context: context,
                    //     title: "OTP VERIFICATION",
                    //     content: Column(
                    //       children: [
                    //         const SizedBox(height: 10.0),
                    //         Pinput(
                    //           length: 6,
                    //           controller: otp,
                    //           focusNode: FocusNode(),
                    //           androidSmsAutofillMethod:
                    //               AndroidSmsAutofillMethod.smsUserConsentApi,
                    //           listenForMultipleSmsOnAndroid: true,
                    //           defaultPinTheme: defaultPinTheme,
                    //           separatorBuilder: (index) =>
                    //               const SizedBox(width: 8),
                    //           hapticFeedbackType:
                    //               HapticFeedbackType.lightImpact,
                    //           onCompleted: (pin) {},
                    //           cursor: Column(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               Container(
                    //                 margin: const EdgeInsets.only(bottom: 9),
                    //                 width: 22,
                    //                 height: 1,
                    //                 color: focusedBorderColor,
                    //               ),
                    //             ],
                    //           ),
                    //           focusedPinTheme: defaultPinTheme.copyWith(
                    //             decoration:
                    //                 defaultPinTheme.decoration!.copyWith(
                    //               borderRadius: BorderRadius.circular(8),
                    //               border: Border.all(color: focusedBorderColor),
                    //             ),
                    //           ),
                    //           submittedPinTheme: defaultPinTheme.copyWith(
                    //             decoration:
                    //                 defaultPinTheme.decoration!.copyWith(
                    //               color: fillColor,
                    //               borderRadius: BorderRadius.circular(19),
                    //               border: Border.all(color: focusedBorderColor),
                    //             ),
                    //           ),
                    //           errorPinTheme: defaultPinTheme.copyBorderWith(
                    //             border: Border.all(color: Colors.redAccent),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     buttons: []).show();
                  } else {
                    Alert(
                      context: context,
                      title: '',
                      desc: 'Invalid Credentials.',
                    ).show();
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
                margin: const EdgeInsets.only(top: 10.0),
                // alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.indigo[900],
                    ),
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
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_up');
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
    );
  }
}
