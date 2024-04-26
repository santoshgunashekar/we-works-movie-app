import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:we_works_movie_app/model/user_location.dart';
import 'package:we_works_movie_app/storage/shared_preferences.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc({
    required this.preferences,
  }) : super(SplashScreenInitial()) {
    on<SplashScreenInitialEvent>(onSplashScreenInitialEvent);
    on<SplashScreenLocationInputEvent>(onSplashScreenLocationInputEvent);
  }

  final Preferences preferences;
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _locationData;

  Future<void> onSplashScreenInitialEvent(
    SplashScreenInitialEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    await getLocation();
  }

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    if (_locationData != null) {
      add(
        SplashScreenLocationInputEvent(
          location: UserLocation(
            longitude: _locationData!.longitude ?? 0.0,
            latitude: _locationData!.latitude ?? 0.0,
          ),
        ),
      );
    }
  }

  Future<void> onSplashScreenLocationInputEvent(
    SplashScreenLocationInputEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    await preferences.setLocation(event.location);
    emit(LandingPageState());
  }
}
