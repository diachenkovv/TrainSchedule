import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/settings_provider.dart';

void main() {
  runApp(const TrainScheduleApp());
}

class TrainScheduleApp extends StatefulWidget {
  const TrainScheduleApp({super.key});

  @override
  State<TrainScheduleApp> createState() => _TrainScheduleAppState();
}

class _TrainScheduleAppState extends State<TrainScheduleApp> {
  final ThemeProvider _themeProvider = ThemeProvider();
  final SettingsProvider _settingsProvider = SettingsProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.addListener(() => setState(() {}));
    _settingsProvider.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Розклад поїздів УЗ',
      theme: _getThemeData(Brightness.light),
      darkTheme: _getThemeData(Brightness.dark),
      themeMode: _themeProvider.themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('uk', 'UA'),
      ],
      locale: const Locale('uk', 'UA'),
      home: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 400),
            child: HomeScreen(
              themeProvider: _themeProvider,
              settingsProvider: _settingsProvider,
            ),
          );
        },
      ),
    );
  }

  ThemeData _getThemeData(Brightness brightness) {
    // Кольори згідно з вимогами
    const primaryColor = Color(0xFF2B2E7F); // Основний колір УЗ
    const lightAccentColor = Color(0xFF2B2E7F); // Акцентний для світлої теми
    const darkAccentColor = Color(0xFF3591E4); // Акцентний для темної теми
    
    final colorScheme = ColorScheme.fromSeed(
      seedColor: brightness == Brightness.dark ? darkAccentColor : lightAccentColor,
      brightness: brightness,
      primary: brightness == Brightness.dark ? darkAccentColor : lightAccentColor,
      secondary: brightness == Brightness.dark ? darkAccentColor : lightAccentColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: brightness == Brightness.dark ? darkAccentColor : primaryColor, // Акцентний колір залежно від теми
        foregroundColor: Colors.white, // Завжди білий текст
        elevation: 0,
        scrolledUnderElevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.light, // Завжди світлі іконки статус-бару
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white, // Білий текст для активної вкладки
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7), // Напівпрозорий білий для неактивної
        labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Жирний шрифт для активної
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal), // Звичайний для неактивної
        indicatorColor: Colors.white, // Білий індикатор
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          foregroundColor: Colors.white, // Завжди білий текст на кнопках
        ),
      ),
      // Не змінювати колір іконок при зміні теми - завжди світлі
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
    );
  }
}


