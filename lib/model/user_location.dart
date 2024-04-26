// Created by Santosh G on 26/04/24.
import 'package:json_annotation/json_annotation.dart';

part 'user_location.g.dart';

@JsonSerializable()
class UserLocation {
  UserLocation({
    required this.longitude,
    required this.latitude,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);

  final double latitude;
  final double longitude;
}
