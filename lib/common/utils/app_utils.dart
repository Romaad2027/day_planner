import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/health/models/heart_rate.dart';
import 'package:day_planner/features/health/models/steps.dart';
import 'package:intl/intl.dart';

import '../assets.dart';
import '../services/credentials_loader.dart';
import '../services/logger.dart';
import 'app_flavor.dart';

Future<Credentials> loadCredentials() async {
  try {
    final credentials = await CredentialsLoader(
      pathToFile: _credentialsFileForFlavor(AppFlavor.prod),
    ).load();
    return credentials;
  } catch (e) {
    log.fine('loadCredentials error: $e');
    rethrow;
  }
}

String _credentialsFileForFlavor(AppFlavor flavor) {
  switch (flavor) {
    case AppFlavor.prod:
      return credentialsProdFile;
    case AppFlavor.dev:
      return credentialsDevFile;
  }
}

class EnumToString {
  String? parse(dynamic enumItem) {
    if (enumItem == null) {
      return null;
    }
    return enumItem.toString().split('.')[1];
  }

  T? fromString<T>(List<T> enumValues, String? value) {
    if (value == null) {
      return null;
    }

    return enumValues.singleWhere((enumItem) => EnumToString().parse(enumItem) == value);
  }
}

Iterable<E> indexedMap<E, T>(
  Iterable<T> items,
  E Function(int index, T item) f,
) sync* {
  var index = 0;
  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
}

bool checkIfDateInRange({required DateTime check, required DateTime begin, required DateTime end}) {
  return (check.isAfter(begin)) && (check.isBefore(end) || check.isAtSameMomentAs(end));
}

DateTime extractTimeFromDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

String formatDateTime(DateTime from, DateTime to) {
  return '${DateFormat('HH:mm').format(from)} - ${DateFormat('HH:mm').format(to)}';
}

int? calculateTotalSteps(List<Steps> steps) {
  if (steps.isEmpty) {
    return null;
  }
  int totalSteps = 0;
  for (var s in steps) {
    totalSteps += s.steps;
  }
  return totalSteps;
}

bool isValidNewEventTime(AddEventModel newEvent, List<DayEvent> existingEvents) {
  for (DayEvent event in existingEvents) {
    if (newEvent.from.isBefore(event.to) && newEvent.to.isAfter(event.from)) {
      return false;
    }
  }
  return true;
}

int? calculateAverageHeartRate(List<HeartRate> heartRates) {
  if (heartRates.isEmpty) {
    return null;
  }
  int totalHeartRate = 0;
  for (var h in heartRates) {
    totalHeartRate += h.heartRate;
  }
  return totalHeartRate ~/ heartRates.length;
}
