import 'package:flutter/material.dart';
import 'package:nitp_social/provider/getit.dart';
import 'package:nitp_social/route_generator.dart';
import 'package:nitp_social/services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Social NITP',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
