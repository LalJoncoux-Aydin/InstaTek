import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/screens/register_screen.dart';
import 'package:instatek/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDdn1q0EK9RU1JMBtqPhfNNjMGUQV5TieE',
            appId: '1:254429523809:web:160dbab7037581ac0d5f20',
            messagingSenderId: '254429523809',
            projectId: 'instatek-6fa75',
            storageBucket: 'instatek-6fa75.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaTek',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout()),
      home: const LoginScreen(),
    );
  }
}
