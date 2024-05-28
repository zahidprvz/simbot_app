import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simbot_app/base_screen.dart';
import 'package:simbot_app/theme/theme.dart';
import 'package:simbot_app/theme/theme_notifier.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = themeNotifier.currentTheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter IP Address',
                hintStyle: TextStyle(color: isDarkMode ? AppTheme.secondaryColor : null),
                labelText: 'IP Address',
                labelStyle: TextStyle(color: isDarkMode ? AppTheme.secondaryColor : null),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: isDarkMode ? theme.primaryColor.withOpacity(0.1) : Colors.white,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: isDarkMode ? theme.primaryColor : null),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    iconSize: 48.0,
                    color: theme.colorScheme.secondary,
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 48.0,
                        color: theme.colorScheme.secondary,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 48.0),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        iconSize: 48.0,
                        color: theme.colorScheme.secondary,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 48.0,
                    color: theme.colorScheme.secondary,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Gyro Values:',
              style: TextStyle(
                color: isDarkMode ? AppTheme.secondaryColor : null
              ),
            ),

            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GyroValueBox(title: 'X', value: '0.00', isDarkMode: isDarkMode),
                GyroValueBox(title: 'Y', value: '0.00', isDarkMode: isDarkMode),
                GyroValueBox(title: 'Z', value: '0.00', isDarkMode: isDarkMode),
              ],
            ),
          ],
        ),
      ),
      selectedIndex: 0,
      onItemTapped: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/help');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/about');
            break;
        }
      },
    );
  }
}

class GyroValueBox extends StatelessWidget {
  final String title;
  final String value;
  final bool isDarkMode;

  const GyroValueBox({required this.title, required this.value, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isDarkMode ? theme.cardColor : Colors.white,
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: isDarkMode ? AppTheme.secondaryColor : AppTheme.primaryColor ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: isDarkMode ? AppTheme.secondaryColor : AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }
}
