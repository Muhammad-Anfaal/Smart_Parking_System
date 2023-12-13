import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
// import 'package:email_auth/email_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> loginUser(String email) async {
  final url = Uri.parse('http://localhost:3300/chota/');

  // Define the data to be sent in the request body
  final Map<String, String> data = {
    'us': email, // Assuming you want to concatenate email and password
  };

  try {
    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS, DELETE, PUT"
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response as needed
      print('Login successful');
      print('Response: ${response.body}');
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

// final Email email = Email(
//   body: 'Email body',
//   subject: 'Email subject',
//   recipients: ['example@example.com'],
//   cc: ['cc@example.com'],
//   bcc: ['bcc@example.com'],
//   attachmentPaths: ['/path/to/attachment.zip'],
//   isHTML: false,
// );
//
// await FlutterEmailSender.send(email);

// final Map<String, String> remoteServerConfiguration = {
//   'server': 'localhost',
//   'serverKey': '3300' // Assuming you want to concatenate email and password
// };
//
// EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");
//
// Future<bool> sendOTP(String email) async {
//   var res = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);
//   if (res == true) {
//     return true;
//   }
//   return false;
// }
//
// Future<bool> verifyOTP(String email, String otp) async {
//   var res = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
//   if (res == true) {
//     return true;
//   }
//   return false;
// }

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool hidePassword = true;
  bool otpCorrect = true;

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  TextEditingController otp = TextEditingController();
  EmailOTP auth = EmailOTP();

  List<List<String>> data = [
    ['f200250@cfd.nu.edu.pk', '123'],
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
                    auth.setConfig(
                        appEmail: "f200250@cfd.nu.edu.pk",
                        appName: "Smart Parking System OTP",
                        userEmail: emailTextField.text,
                        otpLength: 6,
                        otpType: OTPType.digitsOnly);
                    if (await auth.sendOTP() == true) {
                      // ignore: use_build_context_synchronously
                      Alert(
                          context: context,
                          title: "OTP VERIFICATION",
                          content: Column(
                            children: [
                              const SizedBox(height: 10.0),
                              Pinput(
                                length: 6,
                                controller: otp,
                                focusNode: FocusNode(),
                                androidSmsAutofillMethod:
                                    AndroidSmsAutofillMethod.smsUserConsentApi,
                                listenForMultipleSmsOnAndroid: true,
                                defaultPinTheme: defaultPinTheme,
                                separatorBuilder: (index) =>
                                    const SizedBox(width: 8),
                                hapticFeedbackType:
                                    HapticFeedbackType.lightImpact,
                                onCompleted: (pin) async {
                                  if (await auth.verifyOTP(otp: otp.text) ==
                                      true) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamed(context, '/home_page');
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Invalid OTP"),
                                    ));
                                  }
                                },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: focusedBorderColor,
                                    ),
                                  ],
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(19),
                                    border:
                                        Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                  border: Border.all(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                          buttons: []).show();
                    }
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
