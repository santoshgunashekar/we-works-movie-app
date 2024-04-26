part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenEvent {}

class SplashScreenInitialEvent extends SplashScreenEvent {}

class SplashScreenLocationInputEvent extends SplashScreenEvent {

  SplashScreenLocationInputEvent({
    required this.location,
});
  final UserLocation location;
}
