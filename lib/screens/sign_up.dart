import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;

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
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InputField(
                    text: 'Name',
                    icon: Icons.account_circle,
                    textType: TextInputType.name,
                  ),
                  const InputField(
                      text: 'City',
                      icon: Icons.location_on,
                      textType: TextInputType.text),
                  const InputField(
                      text: 'Email address',
                      icon: Icons.mail,
                      textType: TextInputType.emailAddress),
                  const InputField(
                      text: 'Mobile No.',
                      icon: Icons.phone,
                      textType: TextInputType.phone),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextField(
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
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 75.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextField(
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
                      Navigator.pop(context);
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
    );
  }
}

class InputField extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextInputType textType;

  const InputField(
      {super.key,
      required this.text,
      required this.icon,
      required this.textType});

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
