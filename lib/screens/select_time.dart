import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  DateTime today = DateTime.now();
  TimeOfDay? startTime; // Updated: Use TimeOfDay? to allow null values
  TimeOfDay? endTime; // Updated: Use TimeOfDay? to allow null values
  double perHourRate = 50.0;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (!day.isBefore(DateTime.now())) {
      setState(() {
        today = day;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime ?? TimeOfDay.now() : endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      if (!isStartTime &&
          (picked.hour < (startTime?.hour ?? 0) ||
              (picked.hour == (startTime?.hour ?? 0) &&
                  picked.minute < (startTime?.minute ?? 0)))) {
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('End time cannot be before start time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Exit the method if end time is before start time
      }

      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  bool isTimeSelected() {
    return startTime != null && endTime != null;
  }

  double calculateAmount() {
    int hours = (endTime?.hour ?? 0) - (startTime?.hour ?? 0);
    int minutes = (endTime?.minute ?? 0) - (startTime?.minute ?? 0);
    double totalHours = hours + minutes / 60.0;
    return totalHours * perHourRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Time Slot", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: content(),
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("Selected Day = " + today.toString().split(" ")[0]),
          Text(" "),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 12),
              onDaySelected: _onDaySelected,
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.blueAccent,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Start Time', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, true),
                        child: Text('${startTime?.format(context) ?? "Select"}'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('End Time', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context, false),
                        child: Text('${endTime?.format(context) ?? "Select"}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 4,
            color: Colors.blueAccent,
            height: 20,
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Per Hour Rate', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Rs $perHourRate',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Text(
            'Amount: Rs ${calculateAmount().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isTimeSelected()
                ? () {
              Navigator.pushNamed(context, '/payment_page');
              print('Proceed to Payment');
            }
                : null,
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}

