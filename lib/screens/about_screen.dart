import 'package:flutter/material.dart';
import 'package:simbot_app/base_screen.dart';
import 'package:simbot_app/theme/theme.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About SIMBOT',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'SIMBOT - Smart Industrial Maneuverable Robot',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            _buildMissionSection(theme, isDarkMode),
            const SizedBox(height: 24.0),
            _buildSummarySection(theme, isDarkMode),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTeamMemberInfo(
                  context: context,
                  name: 'Zahid Parviz',
                  id: '20021519-143',
                  degree: 'BSCS',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12.0),
                _buildTeamMemberInfo(
                  context: context,
                  name: 'Muhammad Nauman',
                  id: '20021519-090',
                  degree: 'BSCS',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
      selectedIndex: 2,
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

  Widget _buildMissionSection(ThemeData theme, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mission:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'To provide efficient and precise navigation for industrial applications.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTeamMemberInfo({
    required BuildContext context,
    required String name,
    required String id,
    required String degree,
    required bool isDarkMode,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isDarkMode ? theme.primaryColorDark : theme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? theme.colorScheme.secondary : Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            id,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? theme.colorScheme.secondary : Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            degree,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? theme.colorScheme.secondary : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(ThemeData theme, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'The SIMBOT project aims to develop a smart industrial robot for efficient navigation and automation. This app is a part of our final year project.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppTheme.secondaryColor : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
