import 'package:flutter/cupertino.dart';
import 'package:wits_overflow/theme_shared_prefs.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isDark;
  late ThemeSharedPrefs themeSharedPrefs;
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    themeSharedPrefs = ThemeSharedPrefs();
  }
  set isDark(bool value) {
    _isDark = value;
    themeSharedPrefs.setTheme(value);
    notifyListeners();
  }

  getThemePreferences() async {
    _isDark = await themeSharedPrefs.getTheme();
    notifyListeners();
  }
}
