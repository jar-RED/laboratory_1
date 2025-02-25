import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'isDarkMode';

  Future<bool> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  Future<bool> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = !(prefs.getBool(_themeKey) ?? false);
    await prefs.setBool(_themeKey, isDarkMode);
    return isDarkMode;
  }
}
