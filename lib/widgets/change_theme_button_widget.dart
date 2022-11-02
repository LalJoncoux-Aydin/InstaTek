import 'package:flutter/material.dart';
import 'package:instatek/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
        color: Colors.white,
      ),
      onPressed: () {
        themeProvider.toggleTheme(!themeProvider.isDarkMode);
      },
    );
  }
}
