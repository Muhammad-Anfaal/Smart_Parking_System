import 'package:flutter/material.dart';

class ApproveArea extends StatefulWidget {
  const ApproveArea({Key? key}) : super(key: key);

  @override
  State<ApproveArea> createState() => _ApproveAreaState();
}

class _ApproveAreaState extends State<ApproveArea> {
  List<ParkingRequest> pendingRequests = [
    ParkingRequest(name: 'Parking Area 1', capacity: 20, location: 'Location 1'),
    ParkingRequest(name: 'Parking Area 2', capacity: 30, location: 'Location 2'),
    ParkingRequest(name: 'Parking Area 3', capacity: 15, location: 'Location 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.black54],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Approve Parking Areas',
              style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueGrey],
          ),
        ),
        child: ListView.builder(
          itemCount: pendingRequests.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.0),
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blueGrey.shade900, Colors.black87],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Text(
                    pendingRequests[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Capacity: ${pendingRequests[index].capacity}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'Location: ${pendingRequests[index].location}',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        color: Colors.green,
                        onPressed: () {
                          approveRequest(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.red,
                        onPressed: () {
                          rejectRequest(context, index);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void approveRequest(BuildContext context, int index) {
    String name = pendingRequests[index].name;
    pendingRequests.removeAt(index);
    showConfirmationSnackbar(context, 'Approved: $name');
  }

  void rejectRequest(BuildContext context, int index) {
    String name = pendingRequests[index].name;
    pendingRequests.removeAt(index);
    showConfirmationSnackbar(context, 'Rejected: $name');
  }

  void showConfirmationSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey[800],
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class ParkingRequest {
  final String name;
  final int capacity;
  final String location;

  ParkingRequest({
    required this.name,
    required this.capacity,
    required this.location,
  });
}
