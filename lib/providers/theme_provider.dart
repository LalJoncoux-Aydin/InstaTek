import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  Color blueLight = const Color.fromARGB(255, 95, 134, 196);
  Color blueDark = const Color.fromARGB(255, 49, 103, 178);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white,
      secondary: Colors.black,
      tertiary: const Color.fromARGB(255, 49, 103, 178),
      background: Colors.white,
      onBackground: Colors.black,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onTertiary: const Color.fromARGB(255, 30, 79, 138),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.red,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(
        color: Color.fromARGB(255, 95, 134, 196),
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: TextStyle(
        color: Color.fromARGB(255, 49, 103, 178),
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.yellow,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.black,
      secondary: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
