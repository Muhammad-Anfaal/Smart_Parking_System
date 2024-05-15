import 'package:flutter/material.dart';
import 'package:smart_parking_system/screens/Admin/approve_area.dart';
import 'package:smart_parking_system/screens/Admin/home_page_admin.dart';
import 'package:smart_parking_system/screens/Admin/manage_parking_area.dart';
import 'package:smart_parking_system/screens/Admin/manage_subscriptions.dart';
import 'package:smart_parking_system/screens/car_registration.dart';
import 'package:smart_parking_system/screens/extend_time.dart';
import 'package:smart_parking_system/screens/feedback_page.dart';
import 'package:smart_parking_system/screens/owner/extend_area.dart';
import 'package:smart_parking_system/screens/owner/statistics.dart';
import 'package:smart_parking_system/screens/pin_code.dart';
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
        if (settings.name == '/pin_code') {
          final args = settings.arguments as Map<String, String>? ?? {};
          return MaterialPageRoute(
            builder: (context) {
              final userType = args['userType'] ?? 'default';
              final otp = args['otp'] ?? 'default';
              return PinCodeForm(userType: userType, otp: otp);
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
        '/payment_page': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final price = args['price'] as int;
          return JazzCash(price: price);
        },
        '/select_module': (context) => SelectModule(),
        '/register_parking_area': (context) => RegisterParkingArea(),
        '/home_page_owner': (context) => MyHomePageOwner(),
        '/car_registration': (context) => ParkingRegistration(),
        '/feedback_page': (context) => FeedbackPage(),
        '/home_page_admin': (context) => MyHomePageAdmin(),
        '/approve_area': (context) => ApproveArea(),
        '/manage_subscriptions': (context) => ManageSubscriptions(),
        '/manage_parking_area': (context) => ManageParkingArea(),
        '/extend_area': (context) => ExtendArea(),
        '/statistics': (context) => StatisticsPage(),
        '/extend_time': (context) => ExtendTime(),
      },
    );
  }
}
