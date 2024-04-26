part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class LandingPageState extends SplashScreenState {}

class RequestLocationPermission extends SplashScreenState {}
