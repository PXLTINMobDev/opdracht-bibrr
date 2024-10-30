// lib/services/LanguageService.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class LanguageService extends ChangeNotifier {
  Map<String, String> _strings = {};
  String _languageFile = 'assets/strings.json';

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedFile = prefs.getString('language_file');
    _languageFile = storedFile ?? 'assets/strings.json';

    try {
      final String response = await rootBundle.loadString(_languageFile);
      final data = json.decode(response) as Map<String, dynamic>;
      _strings = data.map((key, value) => MapEntry(key, value.toString()));
      notifyListeners();
    } catch (e) {
      print('Error loading strings: $e');
    }
  }

  String getString(String key, [String defaultValue = '']) {
    return _strings[key] ?? defaultValue;
  }

  Future<void> setLanguage(String languageFile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_file', languageFile);
    await loadLanguage(); 
    notifyListeners(); 
  }

  String get currentLanguageCode {
    if (_languageFile.contains('string_dutch')) {
      return 'nl';
    } else {
      return 'en';
    }
  }
}