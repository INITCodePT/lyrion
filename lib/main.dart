import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:lyrion/util/main/handler.dart';
import 'package:lyrion/util/theming/themes.dart';

void main() async {
  //Initialize Services
  await MainProcesses.init();

  //Themes by Platform
  final themes = AppThemes.byPlatform;

  //Initial Route
  final initialRoute = MainProcesses.initialRoute();

  //Run App
  runApp(
    AdaptiveTheme(
      light: themes["android"]["light"],
      dark: themes["android"]["dark"],
      initial: AdaptiveThemeMode.system,
      builder: (theme, dark) {
        return MaterialApp(
          theme: theme,
          darkTheme: dark,
          home: initialRoute,
          localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
        );
      },
    ),
  );
}
