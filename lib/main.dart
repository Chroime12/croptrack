import 'package:croptrack/features/auth/screens/login_screen.dart';
import 'package:croptrack/features/home/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'firebase_options.dart';
import 'package:croptrack/config/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if it hasn't been initialized yet
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;

            if (user != null && user.emailVerified) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
