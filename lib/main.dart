import 'package:flutter/material.dart';
import '/screens/payment_page.dart';
import 'screens/log_in.dart';
import 'screens/sign_up.dart';
import 'screens/home_page.dart';
import 'screens/reservation_page.dart';
import 'screens/select_time.dart';
import 'screens/subscription.dart';
import 'screens/splash_screen.dart';
import 'screens/select_module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/log_in') {
          final args = settings.arguments as Map<String, String>? ?? {};
          return MaterialPageRoute(
            builder: (context) {
              final userType = args['userType'] ?? 'default';
              return LogInPage(userType: userType);
            },
          );
        }
        return null;
      },
      routes: {
        '/': (context) => SplashScreen(),
        '/sign_up': (context) => SignUpPage(),
        '/home_page': (context) => MyHomePage(),
        '/reservation_page': (context) => ReservationPage(),
        '/select_time': (context) => SelectTime(),
        '/subscription': (context) => Subscription(),
        '/payment_page': (context) => PaymentPage(),
        '/select_module': (context) => SelectModule(),
        '/register_parking_area':(context)=>
      },
    );
  }
}

// Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false)

// Navigator.of(context).pop(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => InterestsPage(userAccesstoken: accessToken,)))
