import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';
import 'screens/home/home_page.dart';
import 'screens/onboarding/onboarding_page.dart';

void main() {
  runApp(const PhotoDumpApp());
}

class PhotoDumpApp extends StatefulWidget {
  const PhotoDumpApp({super.key});

  @override
  State<PhotoDumpApp> createState() => _PhotoDumpAppState();
}

class _PhotoDumpAppState extends State<PhotoDumpApp> {
  final ThemeService _themeService = ThemeService();
  bool _isDarkMode = false;
  bool _hasSeenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = await _themeService.loadThemeMode();
    final hasSeen = prefs.getBool('hasSeenOnboarding') ?? false;

    setState(() {
      _isDarkMode = isDark;
      _hasSeenOnboarding = hasSeen;
    });
  }

  Future<void> _toggleTheme() async {
    final isDark = await _themeService.toggleTheme();
    setState(() {
      _isDarkMode = isDark;
    });
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    setState(() {
      _hasSeenOnboarding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapStash',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _hasSeenOnboarding
          ? HomePage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode)
          : OnboardingPage(
              onFinish: _completeOnboarding,
              toggleTheme: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
    );
  }
}
