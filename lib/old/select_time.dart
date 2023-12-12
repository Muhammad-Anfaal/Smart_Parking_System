import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const SelectTime());
}

class SelectTime extends StatelessWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPS',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.blueAccent,
      ),
      home: const Timeslot(),
    );
  }
}

class Timeslot extends StatefulWidget {
  const Timeslot({Key? key}) : super(key: key);

  @override
  State<Timeslot> createState() => _TimeslotState();
}

class _TimeslotState extends State<Timeslot> {
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  double hourlyRate = 50.0;

  bool get isDateAndTimeSelected =>
      selectedDate != null &&
      selectedStartTime != null &&
      selectedEndTime != null;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        selectedStartTime = null;
        selectedEndTime = null;
      });
    }
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedTime;
        } else {
          selectedEndTime = pickedTime;
        }
      });
    }
  }

  double calculateTotalAmount() {
    if (selectedStartTime != null && selectedEndTime != null) {
      final startTime =
          selectedStartTime!.hour + selectedStartTime!.minute / 60.0;
      final endTime = selectedEndTime!.hour + selectedEndTime!.minute / 60.0;

      if (endTime <= startTime) {
        return 0.0;
      }

      final totalHours = endTime - startTime;
      return totalHours * hourlyRate;
    }
    return 0.0;
  }

  void _navigateToPaymentScreen(BuildContext context) {
    Navigator.pushNamed(context, '/payment_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Time Slot',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => _selectDate(),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/deadline.png',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Pick Date',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (selectedDate != null)
              Text(
                'Selected Date: ${DateFormat.yMd().format(selectedDate!)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            const SizedBox(height: 20),
            Container(
              width: 270,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: MaterialButton(
                          onPressed: () => _selectTime(true),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Starting Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (selectedStartTime != null)
                                    Text(
                                      selectedStartTime!.format(context),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: MaterialButton(
                          onPressed: () => _selectTime(false),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ending Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (selectedEndTime != null)
                                    Text(
                                      selectedEndTime!.format(context),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 240,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  Text(
                    'Total Amount: \$${calculateTotalAmount().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isDateAndTimeSelected
                  ? () {
                      // Navigate to the payment screen with a custom page transition
                      _navigateToPaymentScreen(context);
                    }
                  : null,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
