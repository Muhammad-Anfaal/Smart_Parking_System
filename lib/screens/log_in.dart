import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pinput/pinput.dart';

Future connectionBuild() async {
  final conn = await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'SmartParkingSystem',
      username: 'postgres',
      password: 'hizyph3r..',
      port: 5432,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
  print('has connection!');
}

// Future getUrlData() async {
//   var request = http.Request(
//     'GET',
//     Uri.parse('http://127.0.0.1:3300/users/'),
//   );
//   request.headers.addAll({
//     "Accept": "application/json",
//     "Access-Control-Allow-Origin": "*",
//     "Access-Control-Allow-Credentials": "true",
//     "Access-Control-Allow-Methods": "GET"
//   });
//
//   print(request);
//   http.StreamedResponse response = await request.send();
//   print(response);
//   var decode = convert.jsonDecode(await response.stream.bytesToString());
//   return decode;
// }
//
// Future fetchData() async {
//   var response = await http.get(Uri.parse('http://127.0.0.1:3300/users/'));
//
//   if (response.statusCode == 200) {
//     var jsonResponse = response.bodyBytes;
//     print('Number of books about http: $jsonResponse.');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

void sendMeassage(String msg) {
  print(msg);
  WebSocketChannel channel;

  try {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3000'));
    channel.sink.add(msg);

    channel.stream.listen((msg) {
      print(msg);
      channel.sink.close();
    });
  } catch (e) {
    print(e);
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    bool hidePassword = true;

    TextEditingController emailTextField = TextEditingController();
    TextEditingController passwordTextField = TextEditingController();
    TextEditingController otp = TextEditingController();
    EmailOTP auth = EmailOTP();

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

    List<List<String>> data = [
      ['f200250@cfd.nu.edu.pk', '123'],
    ];
    // data.add([emailTextField.text, passwordTextField.text]);

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
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
                  // Navigator.pushNamed(context, '/home_page');
                  // sendMeassage('Hello bacho');
                  connectionBuild();
                  // getUrlData();
                  if (data[0][0] == emailTextField.text &&
                      data[0][1] == passwordTextField.text) {
                    auth.setConfig(
                        appEmail: "f200250@cfd.nu.edu.pk",
                        appName: "Smart Parking System OTP",
                        userEmail: emailTextField.text,
                        otpLength: 6,
                        otpType: OTPType.digitsOnly);
                    if (await auth.sendOTP() == true) {
                      Alert(
                          context: context,
                          title: "OTP VERIFICATION",
                          content: Column(
                            children: [
                              SizedBox(height: 5.0),
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("OTP is verified"),
                                    ));
                                    Navigator.pushNamed(context, '/home_page');
                                  } else {
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
                                ), /**/
                              ),
                            ],
                          ),
                          buttons: []).show();
                    } else {
                      print('OTP did not send');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Incorrect Credentials.'),
                    ));
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
