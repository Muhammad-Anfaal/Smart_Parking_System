import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<ParkingAreaData> parkingAreas = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from database when the widget is initialized
    fetchDataFromDatabase();
  }

  void fetchDataFromDatabase() {
    // Simulate fetching data from a database
    // Replace this with your actual database fetching logic
    List<Map<String, dynamic>> dataFromDatabase = [
      {'name': 'Parking Area 1', 'totalCapacity': 100, 'availableCapacity': 50},
      {'name': 'Parking Area 2', 'totalCapacity': 150, 'availableCapacity': 75},
      {'name': 'Parking Area 3', 'totalCapacity': 200, 'availableCapacity': 130},
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: parkingAreas.map((parkingArea) {
              return SizedBox(
                width: 300,
                child: ParkingCard(
                  name: parkingArea.name,
                  totalCapacity: parkingArea.totalCapacity,
                  availableCapacity: parkingArea.availableCapacity,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final String name;
  final int totalCapacity;
  final int availableCapacity;

  ParkingCard({
    required this.name,
    required this.totalCapacity,
    required this.availableCapacity,
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
              name,
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
                totalCapacity: totalCapacity,
                availableCapacity: availableCapacity,
              ),
            ),
            SizedBox(height: 10),
            CapacityCard(
              title: 'Total Capacity',
              value: totalCapacity,
            ),
            SizedBox(height: 10),
            CapacityCard(
              title: 'Available Capacity',
              value: availableCapacity,
            ),
          ],
        ),
      ),
    );
  }

  Color _calculateCardColor() {
    double percentage = availableCapacity / totalCapacity;
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
