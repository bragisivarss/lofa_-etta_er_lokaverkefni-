import 'package:dundaser/screens/auth.dart';
import 'package:dundaser/screens/main_screen.dart';
import 'package:dundaser/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //Make sure firebase db is initialized in the app and setting options to default
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  //This is the root of the application with some theme configurations
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokaverk',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
          background: const Color.fromARGB(255, 173, 158, 220),
        ),
      ),
      //This is the base of the app which uses streamBuilder so the app
      //is updated on auth changes instead of future builder which only 
      //updates 1 time (the first time a future is found)
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return const MainScreen();
            }

            return const AuthScreen();
          }),
    );
  }
}
