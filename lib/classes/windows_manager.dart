import 'package:flutter/material.dart';

class WindowsManager with ChangeNotifier {
  bool _healthIndicators = false;
  bool _seedOptionsOpen = true;
  bool _harvestToolsOpen = false;
  bool _advisorOpen = true;
  bool _missionsOpen = false;

  WindowsManager();

  /* Getters */

  bool get healthIndicators => _healthIndicators;

  bool get seedOptionsOpen => _seedOptionsOpen;

  bool get harvestToolsOpen => _harvestToolsOpen;

  bool get advisorOpen => _advisorOpen;

  bool get missionsOpen => _missionsOpen;

  /* Setters */

  set healthIndicators(bool newValue) {
    _healthIndicators = newValue;
    notifyListeners();
  }

  set seedOptionsOpen(bool newValue) {
    if (newValue) harvestToolsOpen = false;
    _seedOptionsOpen = newValue;
    notifyListeners();
  }

  set harvestToolsOpen(bool newValue) {
    if (newValue) seedOptionsOpen = false;
    _harvestToolsOpen = newValue;
    notifyListeners();
  }

  set advisorOpen(bool newValue) {
    _advisorOpen = newValue;
    notifyListeners();
  }

  set missionsOpen(bool newValue) {
    _missionsOpen = newValue;
    notifyListeners();
  }

  /* Toggles */

  void toggleSeedOptionsOpen() {
    seedOptionsOpen = !seedOptionsOpen;
  }

  void toggleHarvestToolsOpen() {
    harvestToolsOpen = !harvestToolsOpen;
  }

  void toggleMissionsOpen() {
    missionsOpen = !missionsOpen;
  }
}
