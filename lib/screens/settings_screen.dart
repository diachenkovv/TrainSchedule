import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeProvider themeProvider;
  final SettingsProvider settingsProvider;

  const SettingsScreen({
    super.key,
    required this.themeProvider,
    required this.settingsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Зовнішній вигляд
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette,
                          color: Theme.of(context).colorScheme.primary, // Акцентний колір теми
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Зовнішній вигляд',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Тема',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    _buildThemeSelector(context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Для розробників
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.developer_mode,
                          color: Theme.of(context).colorScheme.primary, // Акцентний колір теми
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Для розробників',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Використовувати mock-дані'),
                      subtitle: const Text('Замість реальних даних з УЗ'),
                      value: settingsProvider.useMockData,
                      onChanged: (value) {
                        settingsProvider.setUseMockData(value);
                      },
                      secondary: Icon(
                        settingsProvider.useMockData ? Icons.science : Icons.cloud,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Про додаток
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.primary, // Акцентний колір теми
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Про додаток',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const ListTile(
                      title: Text('Версія'),
                      subtitle: Text('1.0.0'),
                      leading: Icon(Icons.tag),
                    ),
                    const ListTile(
                      title: Text('Flutter'),
                      subtitle: Text('3.32.5'),
                      leading: Icon(Icons.flutter_dash),
                    ),
                    const ListTile(
                      title: Text('Dart'),
                      subtitle: Text('3.8.1'),
                      leading: Icon(Icons.code),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: const Text('Світла тема'),
          subtitle: const Text('Завжди світла тема'),
          value: ThemeMode.light,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              themeProvider.setThemeMode(value);
            }
          },
          secondary: const Icon(Icons.light_mode),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Темна тема'),
          subtitle: const Text('Завжди темна тема'),
          value: ThemeMode.dark,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              themeProvider.setThemeMode(value);
            }
          },
          secondary: const Icon(Icons.dark_mode),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Системна тема'),
          subtitle: const Text('Слідувати налаштуванням системи'),
          value: ThemeMode.system,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              themeProvider.setThemeMode(value);
            }
          },
          secondary: const Icon(Icons.settings_system_daydream),
        ),
      ],
    );
  }
}
