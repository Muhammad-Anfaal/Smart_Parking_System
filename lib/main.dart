import 'package:flutter/material.dart';
import '/screens/payment_page.dart';
import 'screens/log_in.dart';
import 'screens/sign_up.dart';
import 'screens/home_page.dart';
import 'screens/reservation_page.dart';
import 'screens/select_time.dart';
import 'screens/subscription.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/log_in',
      routes: {
        '/': (context) => SplashScreen(),
        '/log_in': (context) => LogInPage(),
        '/sign_up': (context) => SignUpPage(),
        '/home_page': (context) => MyHomePage(),
        '/reservation_page': (context) => ReservationPage(),
        '/select_time': (context) => SelectTime(),
        '/subscription': (context) => Subscription(),
        '/payment_page': (context) => PaymentPage(),
      },
    );
  }
}
