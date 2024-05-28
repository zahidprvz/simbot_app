import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/about_screen.dart';
import 'screens/help_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/theme_notifier.dart';
import 'theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simbot Control App',
      theme: themeNotifier.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/help': (context) => HelpScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
