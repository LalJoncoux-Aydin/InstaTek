import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instatek/providers/user_provider.dart';
import 'package:instatek/screens/login_screen.dart';
//import 'package:instatek/screens/register_screen.dart';
import 'package:instatek/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'layout/mobile_screen_layout.dart';
import 'layout/responsive_layout_screen.dart';
import 'layout/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDdn1q0EK9RU1JMBtqPhfNNjMGUQV5TieE',
            appId: '1:254429523809:web:160dbab7037581ac0d5f20',
            messagingSenderId: '254429523809',
            projectId: 'instatek-6fa75',
            storageBucket: 'instatek-6fa75.appspot.com',),);
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
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider(),)
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InstaTek',
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const LoginScreen();
            },
          ),
        ),
    );
  }
}
