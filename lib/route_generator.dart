import 'package:flutter/material.dart';
import 'package:nitp_social/src/screens/all_chats_screen.dart/all_chats_screen.dart';
import 'package:nitp_social/src/screens/conversation_screen/conversation_screen.dart';
import 'package:nitp_social/src/screens/home_screen.dart';
import 'package:nitp_social/src/screens/login_screen/login_screen.dart';
import 'package:nitp_social/src/screens/on_boarding_flow/add_photos.dart';
import 'package:nitp_social/src/screens/on_boarding_flow/app_rules.dart';
import 'package:nitp_social/src/screens/on_boarding_flow/complete_profile_screen.dart';
import 'package:nitp_social/src/screens/on_boarding_flow/interest_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const AppRules());
      case '/complete-profile':
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case '/topics':
        return MaterialPageRoute(builder: (_) => const InterestTopicsScreen());
      case '/add-photos':
        return MaterialPageRoute(builder: (_) => const AddPhotosScreen());
      case '/conversation':
        return MaterialPageRoute(builder: (_) => ConverstationScreen(args));
      case '/all-chats':
        return MaterialPageRoute(builder: (_) => const AllChatsScreen());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERRORRR'),
        ),
      );
    });
  }
}
