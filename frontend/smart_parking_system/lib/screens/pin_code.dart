import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_parking_system/screens/sign_up.dart';

class PinCodeForm extends StatefulWidget {
  final String userType, otp;

  const PinCodeForm({super.key, required this.userType, required this.otp});


  @override
  State<PinCodeForm> createState() => _PinCodeFormState();
}

class _PinCodeFormState extends State<PinCodeForm> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text('Enter OTP'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
              ),
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _submitPin(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPin(BuildContext context) {
    String pin = _pinController.text;
    if (pin.length != 6) {
      _showSnackBar(context, 'Pin code must be 6 digits');
      return;
    }
    if (pin == widget.otp) {
      Navigator.pop(context, 'success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Incorrect OTP. Please try again.'),
        ),
      );
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
