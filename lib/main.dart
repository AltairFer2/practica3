import 'package:flutter/material.dart';
import 'package:practica3/assets/global_values.dart';
import 'package:practica3/assets/styles_app.dart';
import 'package:practica3/routes.dart';
import 'package:practica3/screens/dashboard_screen.dart';
import 'package:practica3/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  runApp(LoginApp());
}

Future<void> initSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool rememberMe = prefs.getBool('rememberMe') ?? false;
  bool themePreference = prefs.getBool('themePreference') ??
      true; // Obtén la preferencia del tema o usa un valor predeterminado
  _isLoggedIn = rememberMe; // Actualiza _isLoggedIn en función de rememberMe
  GlobalValues.flaglogin.value = rememberMe;

  // Establece la preferencia de tema en GlobalValues
  GlobalValues.flagTheme.value = themePreference;
}

void setThemePreference(bool isDarkModeEnabled) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('themePreference', isDarkModeEnabled);
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.flagTheme,
        builder: (context, value, _) {
          setThemePreference(value);
          return MaterialApp(
            home: _isLoggedIn ? DashboardScreen() : LoginPage(),
            routes: getRoutes(),
            theme: value
                ? StylesApp.darkTheme(context)
                : StylesApp.lightTheme(context),
          );
        });
  }
}
