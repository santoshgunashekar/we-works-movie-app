import 'package:flutter/material.dart';
import 'package:we_works_movie_app/navigation/routes.dart';
import 'package:we_works_movie_app/presentation/splash_screen/splash_screen_route.dart';

Map<String, WidgetBuilder> routes() {
  return {};
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget widget = const SizedBox();
  switch (settings.name) {
    case Routes.landing:
      widget = const Placeholder();
    case Routes.splashScreen:
      widget = const SplashScreenRouteProvider();
  }
  return MaterialPageRoute(
    builder: (context) => widget,
  );
}
