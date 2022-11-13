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
      secondary: const Color.fromARGB(255, 56, 56, 56),
      tertiary: const Color.fromARGB(255, 10, 81, 161),
      background: Colors.white,
      onBackground: Colors.black,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.black),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color.fromARGB(255, 10, 81, 161),
      selectionColor: Color.fromARGB(255, 180, 213, 255),
      selectionHandleColor: Color.fromARGB(255, 180, 213, 255),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        color: Colors.red,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
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
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      caption: TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.w400,
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
      tertiary: const Color.fromARGB(255, 10, 81, 161),
      background: Colors.black,
      onBackground: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onTertiary: Colors.white,
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
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      caption: TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
