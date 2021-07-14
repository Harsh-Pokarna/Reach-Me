import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachme/constants/Constantcolors.dart';
import 'package:reachme/screens/HomePage/homepage_helpers.dart';
import 'package:reachme/screens/LandingPage/landing_helpers.dart';
import 'package:reachme/screens/LandingPage/landing_services.dart';
import 'package:reachme/screens/LandingPage/landing_utils.dart';
import 'package:reachme/screens/Profile/profile_helpers.dart';
import 'package:reachme/screens/SplashScreen/splash_screen.dart';
import 'package:reachme/services/Authentication.dart';
import 'package:reachme/services/firebase_operations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LandingUtils()),
        ChangeNotifierProvider(create: (_) => LandingService()),
        ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => HomepageHelpers()),
        ChangeNotifierProvider(create: (_) => ProfileHelpers()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: constantColors.blueColor,
          fontFamily: 'Poppins',
          canvasColor: Colors.transparent,
        ),
      ),
    );
  }
}
