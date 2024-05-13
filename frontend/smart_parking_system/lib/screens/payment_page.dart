import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class JazzCash extends StatefulWidget {
  final int price;

  const JazzCash({Key? key, required this.price}) : super(key: key);

  @override
  State<JazzCash> createState() => _JazzCashState();
}

class _JazzCashState extends State<JazzCash> {
  var responsePrice;
  bool isLoading = false;
  String? selectedScheme;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  void payment() async {
    setState(() {
      isLoading = true;
    });

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Payment"),
          content: Text("Are you sure you want to proceed with the payment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Start payment processing
                startPayment();
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Cancel payment
                setState(() {
                  isLoading = false;
                });
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  void startPayment() async {
    // Payment processing logic
    var digest;
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(const Duration(days: 1)));
    String tre = "T" + dateandtime;
    String pp_Amount = widget.price.toString(); // Use the price here
    String pp_BillReference = "billRef";
    String pp_Description = "Description for transaction";
    String pp_Language = "EN";
    String pp_MerchantID = "MC84318";
    String pp_Password = "wz0v030a0g";

    String pp_ReturnURL =
        "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String pp_ver = "1.1";
    String pp_TxnCurrency = "PKR";
    String pp_TxnDateTime = dateandtime.toString();
    String pp_TxnExpiryDateTime = dexpiredate.toString();
    String pp_TxnRefNo = tre.toString();
    String pp_TxnType = "MWALLET";
    String ppmpf_1 = "4456733833993";
    String IntegeritySalt = "5359x15402";
    String and = '&';
    String superdata = IntegeritySalt +
        and +
        pp_Amount +
        and +
        pp_BillReference +
        and +
        pp_Description +
        and +
        pp_Language +
        and +
        pp_MerchantID +
        and +
        pp_Password +
        and +
        pp_ReturnURL +
        and +
        pp_TxnCurrency +
        and +
        pp_TxnDateTime +
        and +
        pp_TxnExpiryDateTime +
        and +
        pp_TxnRefNo +
        and +
        pp_TxnType +
        and +
        pp_ver +
        and +
        ppmpf_1;

    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    String url =
        'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(Uri.parse(url), body: {
      "pp_Version": pp_ver,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": pp_Amount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": dateandtime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime": dexpiredate,
      "pp_ReturnURL": pp_ReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1": "4456733833993"
    });


    // Show toast message for successful payment
    if (response.statusCode == 200) {
      // Fluttertoast.showToast(
      //   msg: 'Payment successful: PKR $pp_Amount',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      // );

      // Navigate to main screen after successful payment after 3 seconds
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, '/home_page_user');
    }

    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black, // Setting navbar color to black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Setting rounded corners
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedScheme,
              onChanged: (value) {
                setState(() {
                  selectedScheme = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Scheme',
                border: OutlineInputBorder(),
              ),
              items: ['Master Card', 'Visa'].map((scheme) {
                return DropdownMenuItem<String>(
                  value: scheme,
                  child: Text(scheme),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cardNumberController,
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cvcController,
              decoration: InputDecoration(
                labelText: 'CVC',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                payment();
              },
              child: Text('Complete Payment'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
