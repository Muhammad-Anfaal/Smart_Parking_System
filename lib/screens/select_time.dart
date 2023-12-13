import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  DateTime today = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
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
      initialTime: isStartTime ? startTime : endTime,
    );
    if (picked != null && picked != (isStartTime ? startTime : endTime)) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  double calculateAmount() {
    int hours = endTime.hour - startTime.hour;
    int minutes = endTime.minute - startTime.minute;
    double totalHours = hours + minutes / 60.0;
    return totalHours * perHourRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(25, 7, 25, 0),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    'Select Time Slot',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Content(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Content() {
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
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
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
                        child: Text('${startTime.format(context)}'),
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
                        child: Text('${endTime.format(context)}'),
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
          SizedBox(height: 10),
          Text(
            'Amount: Rs ${calculateAmount().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/payment_page');
              print('Proceed to Payment');
            },
            child: Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}
