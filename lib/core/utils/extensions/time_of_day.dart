part of core;

extension TimeOfDayExtention on TimeOfDay {
  DateTime get asDateTime {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String get asformatted {
    return asDateTime.toHHMMa;
  }

  String get asHHMM {
    return asDateTime.toHHMM;
  }

  /// Convert a time string to a TimeOfDay
  /// that has format [HH:MM] as 24 Hour
  static TimeOfDay? fromString(String time) {
    try {
      final parts = time.split(':');
      if (parts.length < 2) return null;
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }
}
