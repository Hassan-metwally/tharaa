// ignore_for_file: non_constant_identifier_names

part of core;

enum WeekDayEnum {
  sunday(dayValue: 7, jsonValue: "sunday"),
  monday(dayValue: 1, jsonValue: "monday"),
  tuesday(dayValue: 2, jsonValue: "tuesday"),
  wednesday(dayValue: 3, jsonValue: "wednesday"),
  thursday(dayValue: 4, jsonValue: "thursday"),
  friday(dayValue: 5, jsonValue: "friday"),
  saturday(dayValue: 6, jsonValue: "saturday");

  final int dayValue;
  final String jsonValue;

  const WeekDayEnum({required this.dayValue, required this.jsonValue});

  factory WeekDayEnum.fromJson(String json) {
    return WeekDayEnum.values.firstWhere((element) => element.jsonValue.toLowerCase() == json.toLowerCase());
  }

  String get localizedName {
    switch (this) {
      case WeekDayEnum.sunday:
        return appLocalizer.sunday;
      case WeekDayEnum.monday:
        return appLocalizer.monday;
      case WeekDayEnum.tuesday:
        return appLocalizer.tuesday;
      case WeekDayEnum.wednesday:
        return appLocalizer.wednesday;
      case WeekDayEnum.thursday:
        return appLocalizer.thursday;
      case WeekDayEnum.friday:
        return appLocalizer.friday;
      case WeekDayEnum.saturday:
        return appLocalizer.saturday;
    }
  }
}

extension DateTimeExtention on DateTime {
  WeekDayEnum get dayType => WeekDayEnum.values.firstWhere((element) => element.dayValue == weekday);
}

/// DateTime Format Extensions
///
///
extension DateTimeFormatExtention on DateTime {
  // 04:30 AM
  String get toHHMMa {
    return intel.DateFormat('hh:mm a', getLocale.languageCode).format(this);
  }

  // 14:30
  // 10:30
  String get toHHMM {
    return intel.DateFormat('hh:mm', getLocale.languageCode).format(this);
  }

  // Feb 03,2023
  String get dMMMy {
    return intel.DateFormat('MMM dd,y', getLocale.languageCode).format(this);
  }

  // sunday - 3 september 2023
  String get toEEEEdMMMMy {
    return intel.DateFormat('EEEE - d MMMM y', getLocale.languageCode).format(this);
  }

  // september 2023
  String get toMMMMy {
    return intel.DateFormat('MMMM y', getLocale.languageCode).format(this);
  }

  // Feb 2023
  String get MMMYYYY {
    return intel.DateFormat('MMM yyyy', getLocale.languageCode).format(this);
  }

  // Mon || Sun
  String get dd {
    return intel.DateFormat('E', getLocale.languageCode).format(this);
  }

  // 03 May 2023
  String get ddMMMyyyy {
    return intel.DateFormat('dd MMM yyyy', getLocale.languageCode).format(this);
  }

  // 03 May
  String get ddMM {
    return intel.DateFormat('dd MMM', getLocale.languageCode).format(this);
  }

  // Output: 12 Feb 2024 , 9:00 PM
  String get DMYHMA {
    return intel.DateFormat('dd MMM yyyy , h:mm a', getLocale.languageCode).format(this);
  }

  // Output: Mon 12 Feb , 9:00 PM
  String get EDMMMHMMA {
    return intel.DateFormat('E d MMM , h:mm a', getLocale.languageCode).format(this);
  }

  // Output: 12/Feb/2026 - 9:00 PM
  String get DDMMMYYYY_HHMMA {
    return intel.DateFormat('dd/MM/yyyy - h:mm a', 'en').format(this);
  }

  // Output: Mon 12 Feb
  String get EDMMM {
    return intel.DateFormat('E d MMM', getLocale.languageCode).format(this);
  }

  // Output:  12 Feb
  String get DMMM {
    return intel.DateFormat('d MMM', getLocale.languageCode).format(this);
  }

  // Output: Mon 9:00 PM
  String get EHHMMA {
    return intel.DateFormat('E h:mm a', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd HH:mm:ss"
  String get YYYMMDDHHmmss {
    return intel.DateFormat('yyyy-MM-dd HH:mm:ss', getLocale.languageCode).format(this);
  }

  // Output: 15/12/2023
  String get DDMMYYYY {
    return intel.DateFormat('dd/MM/yyyy', getLocale.languageCode).format(this);
  }

  // Output: 2023/12/15
  String get YYYYMMDD {
    return intel.DateFormat('yyyy/MM/dd', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd"
  String get YYYY_MM_DD {
    return intel.DateFormat('yyyy-MM-dd', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd EN"
  String get YYYY_MM_DD_EN {
    return intel.DateFormat('yyyy-MM-dd', 'en').format(this);
  }
}

/// DateTime Time Aago Extension
///
///
extension DateTimeAgoExtension on DateTime {
  // String timeAgo({DateTime? clock}) {
  //   final now = clock ?? DateTime.now();
  //   final difference = now.difference(this);

  //   if (difference.inSeconds < 60) {
  //     return intel.Intl.plural(
  //       difference.inSeconds,
  //       one: appLocalizer.justNow,
  //       other: '${difference.inSeconds} ${appLocalizer.seconds}',
  //     );
  //   } else if (difference.inMinutes < 60) {
  //     return intel.Intl.plural(
  //       difference.inMinutes,
  //       one: '${difference.inMinutes} ${appLocalizer.minute}',
  //       other: '${difference.inMinutes} ${appLocalizer.minutes}',
  //     );
  //   } else if (difference.inHours < 24) {
  //     return intel.Intl.plural(
  //       difference.inHours,
  //       one: '${difference.inHours} ${appLocalizer.hour}',
  //       other: '${difference.inHours} ${appLocalizer.hours}',
  //     );
  //   } else if (difference.inDays < 7) {
  //     return intel.Intl.plural(
  //       difference.inDays,
  //       one: '${difference.inDays} ${appLocalizer.day}',
  //       other: '${difference.inDays} ${appLocalizer.days}',
  //     );
  //   } else if (difference.inDays < 30) {
  //     final weeks = (difference.inDays / 7).floor();
  //     return intel.Intl.plural(
  //       weeks,
  //       one: '$weeks ${appLocalizer.week}',
  //       other: '$weeks ${appLocalizer.weeks}',
  //     );
  //   } else if (difference.inDays < 365) {
  //     final months = (difference.inDays / 30).floor();
  //     return intel.Intl.plural(
  //       months,
  //       one: '$months ${appLocalizer.month}',
  //       other: '$months ${appLocalizer.months}',
  //     );
  //   } else {
  //     final years = (difference.inDays / 365).floor();
  //     return intel.Intl.plural(
  //       years,
  //       one: '$years ${appLocalizer.year}',
  //       other: '$years ${appLocalizer.years}',
  //     );
  //   }
  // }
}
