import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _selectedLanguage = 'English';
  String get selectedLanguage => _selectedLanguage;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    if (newLanguage != _selectedLanguage) {
      _selectedLanguage = newLanguage;
      notifyListeners();
    }
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: settingsProvider.isDarkMode,
            onChanged: (value) {
              settingsProvider.toggleDarkMode();
            },
          ),
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: settingsProvider.selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  settingsProvider.changeLanguage(newValue);

                  String locale = 'en';
                  if (newValue == 'Spanish') {
                    locale = 'es';
                  } else if (newValue == 'French') {
                    locale = 'fr';
                  }

                  Locale newLocale = Locale(locale);
                  Intl.defaultLocale = newLocale.toString();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/SettingsPage');
                }
              },
              items: <String>['English', 'Spanish', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
