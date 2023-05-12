import 'package:flutter/material.dart';
import 'package:nitp_social/provider/getit.dart';
import 'package:nitp_social/route_generator.dart';
import 'package:nitp_social/services/navigation_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: 'WallFlower',
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(195, 226, 10, 10),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffff6f59),
            primary: const Color(0xffff6f59),
            secondary: const Color.fromARGB(195, 226, 10, 10)),
        // set text color to white
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          bodyText2: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          overline: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ).apply(
          fontFamily: GoogleFonts.raleway().fontFamily,
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(195, 226, 10, 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(195, 226, 10, 10),
            textStyle: const TextStyle(color: Colors.white, fontSize: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
