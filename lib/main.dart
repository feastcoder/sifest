import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdminMenuApp());
}

class AdminMenuApp extends StatelessWidget {
  const AdminMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Menu Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
