import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../providers/settings_provider.dart';
import '../generated/l10n.dart';

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
        title: Text(S.of(context).settings),
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
                          S.of(context).appearance,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).theme,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    _buildThemeSelector(context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Вибір мови
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          S.of(context).language,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<Locale>(
                      value: settingsProvider.locale,
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          settingsProvider.setLocale(newLocale);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: const Locale('uk', 'UA'),
                          child: Text(S.of(context).language_uk),
                        ),
                        DropdownMenuItem(
                          value: const Locale('en', ''),
                          child: Text(S.of(context).language_en),
                        ),
                      ],
                    ),
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
                          S.of(context).developer,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(S.of(context).use_mock_data),
                      subtitle: Text(S.of(context).use_mock_data_subtitle),
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
                          S.of(context).about,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(S.of(context).app_info),
                    ListTile(
                      title: Text(S.of(context).version),
                      subtitle: const Text('1.0.0'),
                      leading: const Icon(Icons.tag),
                    ),
                    ListTile(
                      title: Text(S.of(context).flutter),
                      subtitle: const Text('3.32.5'),
                      leading: const Icon(Icons.flutter_dash),
                    ),
                    ListTile(
                      title: Text(S.of(context).dart),
                      subtitle: const Text('3.8.1'),
                      leading: const Icon(Icons.code),
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
          title: Text(S.of(context).themeModeLight),
          subtitle: Text(S.of(context).themeModeLightDesc),
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
          title: Text(S.of(context).themeModeDark),
          subtitle: Text(S.of(context).themeModeDarkDesc),
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
          title: Text(S.of(context).themeModeSystem),
          subtitle: Text(S.of(context).themeModeSystemDesc),
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
