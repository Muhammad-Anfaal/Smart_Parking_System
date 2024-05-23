import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> data = [];

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<ParkingAreaData> parkingAreas = [];

  Future<void> fetchData() async {
    String ipAddress = '192.168.137.1'; // lan adapter ip address
    final url = Uri.parse('http://$ipAddress:3800/usertimes');

    try {
      final response = await http.get(url);
      print('success');
      print(response.body);
      print(jsonDecode(response.body));
      setState(() {
        data = jsonDecode(response.body);
      });
      print('***********************************************');
      print(data.length);
    } catch (e) {
      print('%%%Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch data from database when the widget is initialized
    fetchDataFromDatabase();
  }

  void fetchDataFromDatabase() {
    // fetchData();
    // Simulate fetching data from a database
    // Replace this with your actual database fetching logic
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    print(data.length);
    List<Map<String, dynamic>> dataFromDatabase = [
      {'name': 'fast cfd', 'totalCapacity': 250, 'availableCapacity': 247},
      // {'name': 'Parking Area 2', 'totalCapacity': 150, 'availableCapacity': 75},
      // {
      //   'name': 'Parking Area 3',
      //   'totalCapacity': 200,
      //   'availableCapacity': 130
      // },
    ];

    // Convert data from database to ParkingAreaData objects and add them to the list
    List<ParkingAreaData> fetchedData = dataFromDatabase.map((data) {
      return ParkingAreaData(
        name: data['name'],
        totalCapacity: data['totalCapacity'],
        availableCapacity: data['availableCapacity'],
      );
    }).toList();

    setState(() {
      parkingAreas = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: ExpansionTile(
                  title: Text('Parking Areas'),
                  children: parkingAreas.map((parkingArea) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ParkingCard(parkingArea: parkingArea),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              // ReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final ParkingAreaData parkingArea;

  ParkingCard({
    required this.parkingArea,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor = _calculateCardColor();
    return Card(
      elevation: 4,
      color: cardColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              parkingArea.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 180,
              height: 180,
              child: DonutChart(
                totalCapacity: parkingArea.totalCapacity,
                availableCapacity: parkingArea.availableCapacity,
              ),
            ),
            SizedBox(height: 10),
            CapacityCard(
              title: 'Total Capacity',
              value: parkingArea.totalCapacity,
            ),
            SizedBox(height: 10),
            CapacityCard(
              title: 'Available Capacity',
              value: parkingArea.availableCapacity,
            ),
          ],
        ),
      ),
    );
  }

  Color _calculateCardColor() {
    double percentage =
        parkingArea.availableCapacity / parkingArea.totalCapacity;
    if (percentage > 0.8) {
      return Colors.redAccent;
    } else if (percentage > 0.5) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }
}

class DonutChart extends StatelessWidget {
  final int totalCapacity;
  final int availableCapacity;

  DonutChart({
    required this.totalCapacity,
    required this.availableCapacity,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: availableCapacity.toDouble(),
            color: Colors.pinkAccent[100],
            title: 'Available\n$availableCapacity',
            radius: 40,
          ),
          PieChartSectionData(
            value: (totalCapacity - availableCapacity).toDouble(),
            color: Colors.blueAccent[400],
            title: 'Total\n$totalCapacity',
            radius: 40,
          ),
        ],
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 20,
        startDegreeOffset: -90,
      ),
    );
  }
}

class CapacityCard extends StatelessWidget {
  final String title;
  final int value;

  CapacityCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text('$value'),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final int numberOfStars = 5; // Number of stars to display

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Check if there's no review data available
            // If so, display placeholder stars
            // Otherwise, display the actual review content
            _buildReviewContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewContent() {
    // Simulate whether review data is available or not
    bool hasReviewData = false;

    if (hasReviewData) {
      // Display actual review content
      // Replace this with your review content widget
      return Container(
        // Add your review content here
        child: Text('Actual review content'),
      );
    } else {
      // Display placeholder stars
      return Row(
        children: List.generate(
          numberOfStars,
          (index) => Icon(
            Icons.star,
            color: Colors.amber,
            size: 30,
          ),
        ),
      );
    }
  }
}

class ParkingAreaData {
  final String name;
  final int totalCapacity;
  final int availableCapacity;

  ParkingAreaData({
    required this.name,
    required this.totalCapacity,
    required this.availableCapacity,
  });
}
