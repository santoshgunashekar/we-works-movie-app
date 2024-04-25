import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:we_works_movie_app/bloc/bloc_observer.dart';
import 'package:we_works_movie_app/di/di.dart';
import 'package:we_works_movie_app/generated/l10n.dart';
import 'package:we_works_movie_app/l10n/locale_manager.dart';
import 'package:we_works_movie_app/navigation/routes.dart';
import 'package:we_works_movie_app/navigation/routes_initializer.dart';
import 'package:we_works_movie_app/storage/shared_preferences.dart';
import 'package:we_works_movie_app/style/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DI.initializeDependencies();
  await DI.inject<Preferences>().init();
  Bloc.observer = AppBlocObserver();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>(create: (_) => ThemeManager()),
        ChangeNotifierProvider<LocaleManager>(create: (_) => LocaleManager()),
      ],
      child: const WeWorksMovieApp(),
    ),
  );
}

class WeWorksMovieApp extends StatefulWidget {
  const WeWorksMovieApp({
    super.key,
  });

  @override
  State<WeWorksMovieApp> createState() => _WeWorksMovieAppState();
}

class _WeWorksMovieAppState extends State<WeWorksMovieApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.splashScreen,
      onGenerateRoute: onGenerateRoute,
      routes: routes(),
      theme: Provider.of<ThemeManager>(context).themeData,
      locale: Provider.of<LocaleManager>(context).locale,
      supportedLocales: Strings.delegate.supportedLocales,
      localizationsDelegates: const [
        Strings.delegate,
      ],
    );
  }
}
