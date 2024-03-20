import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitFeedback() {
    if (_rating == 0) {
      // Show error message if rating is not selected
      _showSnackbar('Please select a rating', Colors.red);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Do you want to submit your feedback?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackbar('Feedback not submitted', Colors.red);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackbar('Feedback submitted', Colors.green);
                // You can add your submission logic here
                print('Rating: $_rating');
                print('Comment: ${_commentController.text}');
                // Reset fields after submission
                setState(() {
                  _rating = 0;
                  _commentController.clear();
                });
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set app bar color to blue
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Set back arrow color to white
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Feedback Page', style: TextStyle(color: Colors.white)), // Set title text color to white
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20.0),
          color: Colors.blue[50], // Set card background color to light blue
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Rate our app:',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 1; i <= 5; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            _rating = i;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Icon(
                                _rating >= i ? Icons.star : Icons.star_border,
                                color: Colors.orange, // Set star color to blue
                              ),
                              Text(
                                getRatingLabel(i),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _commentController, // Set the text controller
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here...',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white, // Set text field background color to white
                    filled: true,
                  ),
                  maxLines: 3,
                  maxLength: 100,
                  onChanged: (value) {
                    // No need to manage text manually, it's handled by the controller
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey, // Set button color to blue
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Bad';
      case 2:
        return 'Poor';
      case 3:
        return 'Okay';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    // Dispose the text controller to prevent memory leaks
    _commentController.dispose();
    super.dispose();
  }
}
