import 'package:flutter/widgets.dart';
import 'package:practica3/screens/dashboard_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => DashboardScreen(),
  };
}
