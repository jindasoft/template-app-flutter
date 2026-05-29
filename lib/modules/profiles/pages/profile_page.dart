import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) {
          return ListView(
            padding: const EdgeInsets.all(ThemeConfig.spacingBase),
            children: [
              // Theme Settings Section
              _buildSectionTitle(context, 'Settings'),
              const SizedBox(height: ThemeConfig.spacingSmall),
              _buildThemeToggle(context, themeNotifier),
              const SizedBox(height: ThemeConfig.spacingMedium),

              ElevatedButton(
                onPressed: () {
                  // Handle logout logic here
                },
                child: const Text('Logout'),
              ),
              const SizedBox(height: ThemeConfig.spacingBase),
              OutlinedButton(
                onPressed: () {
                  // Handle delete account logic here
                },
                child: const Text('Delete Account'),
              ),
              const SizedBox(height: ThemeConfig.spacingMedium),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: ThemeConfig.spacingMedium),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildThemeToggle(BuildContext context, ThemeNotifier themeNotifier) {
    return Card(
      child: ListTile(
        title: const Text('Dark Mode'),
        subtitle: const Text('Toggle between light and dark theme'),
        trailing: Switch(
          value: themeNotifier.themeMode == ThemeMode.dark,
          onChanged: (isDark) {
            themeNotifier.setTheme(isDark ? ThemeMode.dark : ThemeMode.light);
          },
        ),
      ),
    );
  }
}
