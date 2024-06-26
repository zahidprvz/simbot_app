import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simbot_app/base_screen.dart';
import 'package:simbot_app/theme/theme.dart';
import 'package:simbot_app/theme/theme_notifier.dart';
import 'dart:convert';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ipController = TextEditingController();
  String _ipAddress = '';
  Map<String, String> _gyroValues = {'X': '0.00', 'Y': '0.00', 'Z': '0.00'};
  bool _isFetching = false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = themeNotifier.currentTheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12.0),
              TextField(
                controller: _ipController,
                decoration: InputDecoration(
                  hintText: 'Enter IP Address',
                  hintStyle: TextStyle(
                      color: isDarkMode ? AppTheme.secondaryColor : null),
                  labelText: 'IP Address',
                  labelStyle: TextStyle(
                      color: isDarkMode ? AppTheme.secondaryColor : null),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: isDarkMode
                      ? theme.primaryColor.withOpacity(0.1)
                      : Colors.white,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: isDarkMode ? Colors.white : null),
                onSubmitted: (_) {
                  setState(() {
                    _ipAddress = _ipController.text;
                    _fetchGyroValues();
                  });
                },
              ),
              const SizedBox(height: 24.0),
              Center(
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      iconSize: 48.0,
                      color: theme.colorScheme.secondary,
                      onPressed: () => _sendCommand('forward'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 48.0,
                          color: theme.colorScheme.secondary,
                          onPressed: () => _sendCommand('left'),
                        ),
                        const SizedBox(width: 48.0),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          iconSize: 48.0,
                          color: theme.colorScheme.secondary,
                          onPressed: () => _sendCommand('right'),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 48.0,
                      color: theme.colorScheme.secondary,
                      onPressed: () => _sendCommand('backward'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Gyro Values:',
                style: TextStyle(
                    color: isDarkMode ? AppTheme.secondaryColor : null),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GyroValueBox(
                      title: 'X',
                      value: _gyroValues['X']!,
                      isDarkMode: isDarkMode),
                  GyroValueBox(
                      title: 'Y',
                      value: _gyroValues['Y']!,
                      isDarkMode: isDarkMode),
                  GyroValueBox(
                      title: 'Z',
                      value: _gyroValues['Z']!,
                      isDarkMode: isDarkMode),
                ],
              ),
            ],
          ),
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

  void _fetchGyroValues() async {
    setState(() {
      _isFetching = true;
    });

    while (_isFetching) {
      try {
        final response = await HttpClient()
            .getUrl(Uri.parse('http://$_ipAddress/gyro'))
            .then((request) => request.close());

        if (response.statusCode == 200) {
          final String content = await response.transform(utf8.decoder).join();
          final Map<String, dynamic> data = json.decode(content);
          setState(() {
            _gyroValues = {
              'X': data['gyroX'].toString(),
              'Y': data['gyroY'].toString(),
              'Z': data['gyroZ'].toString(),
            };
          });
        } else {
          print('Error fetching gyro values: HTTP ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching gyro values: $e');
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _sendCommand(String command) async {
    if (_ipAddress.isEmpty) {
      print('IP address is not set');
      return;
    }

    print('Sending command to http://$_ipAddress/$command');

    try {
      final response = await HttpClient()
          .getUrl(Uri.parse('http://$_ipAddress/$command'))
          .then((request) => request.close());

      if (response.statusCode == 200) {
        print('Command $command sent successfully');
      } else {
        print('Error sending command: ${response.statusCode}');
      }
    } catch (e) {
      print('Connection error: $e');
    }
  }

  @override
  void dispose() {
    _isFetching = false;
    super.dispose();
  }
}

class GyroValueBox extends StatelessWidget {
  final String title;
  final String value;
  final bool isDarkMode;

  const GyroValueBox(
      {required this.title, required this.value, required this.isDarkMode});

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
            style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode
                    ? AppTheme.secondaryColor
                    : AppTheme.primaryColor),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? AppTheme.secondaryColor
                    : AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }
}
