import 'package:flutter/material.dart';
import 'package:we_works_movie_app/navigation/routes.dart';

Map<String, WidgetBuilder> routes() {
  return {
    Routes.landing: (context) => const Placeholder(),
  };
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget widget = const SizedBox();
  switch (settings.name) {
    case Routes.landing:
      widget = const Placeholder();
  }
  return MaterialPageRoute(
    builder: (context) => widget,
  );
}
