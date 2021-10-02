import 'package:flutter/widgets.dart';

import '../ui/home/home_page.dart';
import '../ui/login/login_page.dart';
import '../ui/splash/splash_page.dart';

class AppRoute {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    splashRoute: (BuildContext context) {
      return const SplashPage();
    },
    loginRoute: (BuildContext context) {
      return const LoginPage();
    },
    homeRoute: (BuildContext context) {
      return const HomePage();
    },
  };
}
