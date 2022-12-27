import 'package:flutter/material.dart';
import 'package:vitec_travels/routes/routes.dart';
import 'package:vitec_travels/ui/home/home.ui.dart';

import '../ui/bottomNavigation.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreens: return MaterialPageRoute(builder: (_) => const HomeNavigation());

      default:
        return MaterialPageRoute(builder: (_) => const HomeNavigation());

    }
  }
}