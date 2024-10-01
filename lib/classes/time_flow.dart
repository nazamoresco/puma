import 'package:flutter/material.dart';
import 'dart:async';

import 'package:game/classes/season.dart';

extension TimeSeason on DateTime {
  Season get season {
    if (month < 3) {
      return Season.summer;
    } else if (month == 3) {
      return day >= 21 ? Season.fall : Season.summer;
    } else if (month < 6) {
      return Season.fall;
    } else if (month == 6) {
      return day >= 21 ? Season.winter : Season.fall;
    } else if (month < 9) {
      return Season.winter;
    } else if (month == 9) {
      return day >= 21 ? Season.spring : Season.winter;
    } else if (month < 12) {
      return Season.spring;
    } else if (month == 12) {
      return day >= 21 ? Season.summer : Season.spring;
    }

    throw "Undefined day $this for Season";
  }

  List<DateTime> get seasonStartEndDates {
    switch (season) {
      case Season.winter:
        return [DateTime(year, 6, 21), DateTime(year, 9, 20)];
      case Season.summer:
        final summerYear = month == 12 ? year : year - 1;
        return [DateTime(summerYear, 12, 21), DateTime(summerYear + 1, 3, 20)];
      case Season.fall:
        return [DateTime(year, 3, 21), DateTime(year, 6, 20)];
      case Season.spring:
        return [DateTime(year, 9, 21), DateTime(year, 12, 20)];
    }
  }

  double get seasonCompletionPercentage {
    List<DateTime> seasonStartEnd = seasonStartEndDates;
    DateTime seasonStart = seasonStartEnd[0];
    DateTime seasonEnd = seasonStartEnd[1];

    int seasonDuration = seasonEnd.difference(seasonStart).inDays + 1;
    int daysIntoSeason = difference(seasonStart).inDays + 1;

    return (daysIntoSeason / seasonDuration) * 100;
  }
}

class TimeFlow with ChangeNotifier {
  DateTime currentTime = DateTime.now();

  Timer? _timeInertia;

  TimeFlow() {
    resume();
  }

  bool get isFlowing => _timeInertia != null;

  void stop() {
    _timeInertia?.cancel();
    _timeInertia = null;
    notifyListeners();
  }

  void resume() {
    // Define the duration of the interval between function calls
    const duration = Duration(seconds: 1);

    // Create a Timer that calls 'myFunction' every 'duration' interval
    _timeInertia = Timer.periodic(duration, (Timer timer) {
      currentTime = currentTime.add(const Duration(days: 1));
      notifyListeners();
    });

    // NM: First iteration instantly so it's responsive to the user.
    currentTime = currentTime.add(const Duration(days: 1));
    notifyListeners();
  }

  @override
  void dispose() {
    _timeInertia?.cancel();
    _timeInertia = null;

    super.dispose();
  }
}
