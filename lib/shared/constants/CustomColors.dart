import "package:flutter/material.dart";

class CustomColors {
  final Color _activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  final Color _activeSecundaryButton = const Color.fromARGB(255, 154, 168, 238);
  final Color _gradientMainColor = Colors.blue;
  final Color _gradientSecColor = Colors.red;

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getActiveSecundaryButtonColor() {
    return _activeSecundaryButton;
  }

  Color getgradientMainColor() {
    return _gradientMainColor;
  }

  Color getgradientSetColor() {
    return _gradientSecColor;
  }
}
