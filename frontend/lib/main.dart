import 'package:flutter/material.dart';
import 'package:smart_parking_system/screens/car_registration.dart';
import 'package:smart_parking_system/screens/feedback_page.dart';
import '/screens/payment_page.dart';
import 'screens/log_in.dart';
import 'screens/sign_up.dart';
import 'screens/home_page_user.dart';
import 'screens/reservation_page.dart';
import 'screens/select_time.dart';
import 'screens/subscription.dart';
import 'screens/splash_screen.dart';
import 'screens/select_module.dart';
import 'screens/owner/register_parking_area.dart';
import 'screens/owner/home_page_owner.dart';

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
        if (settings.name == '/sign_up') {
          final args = settings.arguments as Map<String, String>? ?? {};
          return MaterialPageRoute(
            builder: (context) {
              final userType = args['userType'] ?? 'default';
              return SignUpPage(userType: userType);
            },
          );
        }
        return null;
      },
      routes: {
        '/': (context) => SplashScreen(),
        '/home_page_user': (context) => MyHomePageUser(),
        '/reservation_page': (context) => ReservationPage(),
        '/select_time': (context) => SelectTime(),
        '/subscription': (context) => Subscription(),
        '/payment_page': (context) => JazzCash(),
        '/select_module': (context) => SelectModule(),
        '/register_parking_area': (context) => RegisterParkingArea(),
        '/home_page_owner': (context) => MyHomePageOwner(),
        '/car_registration':(context)=>ParkingRegistration(),
        '/feedback_page':(context)=>FeedbackPage(),
      },
    );
  }
}

// Navigator.of(context).pop(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => InterestsPage(userAccesstoken: accessToken,)))

