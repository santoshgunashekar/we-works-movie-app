import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:we_works_movie_app/storage/shared_preferences.dart';
import 'package:we_works_movie_app/web_service/movies/movie_repository.dart';

class DI {
  DI();

  factory DI.initializeDependencies() {
    addDependency<Preferences>(PreferencesImpl());
    addDependency<MovieRepository>(
      MovieRepositoryImpl(
        preferences: DI.inject(),
      ),
    );
    return DI();
  }

  static void addDependency<T>(
    T object, {
    bool isSingleton = true,
  }) {
    Injector().map<T>((injector) => object, isSingleton: isSingleton);
  }

  static void addStringDependency(String value, String key) {
    Injector().map<String>((injector) => value, key: key);
  }

  static void addDependencyForKey<T>(
    T object,
    String key, {
    bool isSingleton = true,
  }) {
    Injector().map<T>((injector) => object, isSingleton: isSingleton, key: key);
  }

  static T inject<T>() {
    return Injector().get<T>();
  }

  static T injectWithKey<T>(String key) {
    return Injector().get<T>(key: key);
  }

  static T injectWithAdditionalParams<T>(
    String key,
    Map<String, dynamic> additionalParameters,
  ) {
    return Injector()
        .get<T>(key: key, additionalParameters: additionalParameters);
  }
}
