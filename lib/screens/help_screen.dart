import 'package:flutter/material.dart';
import 'package:simbot_app/base_screen.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Manual',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              _buildInstruction(
                context,
                '1. Connect to the robot\'s access point by entering its IP address.',
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
              ),
              const SizedBox(height: 8.0),
              _buildInstruction(
                context,
                '2. Use the arrow buttons to control the robot\'s movement.',
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
              ),
              const SizedBox(height: 8.0),
              _buildInstruction(
                context,
                '3. Monitor the gyro values in real-time on the home screen.',
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
              ),
              const SizedBox(height: 8.0),
              _buildInstruction(
                context,
                '4. Switch between light and dark themes using the toggle button.',
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
              ),
              // Add more instructions as needed
            ],
          ),
        ),
      ),
      selectedIndex: 1,
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

  Widget _buildInstruction(BuildContext context, String text, {required bool isDarkMode}) {
    return ListTile(
      leading: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: isDarkMode ? Theme.of(context).colorScheme.secondary : Colors.white,
        ),
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDarkMode ? Theme.of(context).colorScheme.secondary : null,
            ),
      ),
    );
  }
}
