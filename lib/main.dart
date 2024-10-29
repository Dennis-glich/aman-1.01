import 'package:flutter/material.dart';
import 'screen/auth.dart';
import 'screen/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterPage(),
        '/signin': (context) => SignInPage(),
      },
    );
  }
}
