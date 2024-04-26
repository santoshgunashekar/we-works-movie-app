// Created by Santosh G on 26/04/24.

import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void pushReplacement(String route) {
    Navigator.of(this).pushReplacementNamed(route);
  }
}
