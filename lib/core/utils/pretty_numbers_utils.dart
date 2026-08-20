part of core;

class TimePreviewUtils {
  final DateTime date;
  late final DateTime endDate;

  TimePreviewUtils({required this.date, DateTime? endDate}) {
    this.endDate = endDate ?? DateTime.now();
  }

  Duration get differenceDuration => endDate.difference(date);

  int get differenceMinites => differenceDuration.inMinutes;
  int get differenceHours => differenceDuration.inHours;
  int get differenceInDays => differenceDuration.inDays;
  int get differenceInWeeks => differenceDuration.inDays ~/ 7;
  int get differenceInMonths => differenceDuration.inDays ~/ 30;
  int get differenceInYears => differenceDuration.inDays ~/ 365;

  String prettyText() {
    if (differenceMinites <= 5) {
      return "now";
    } else if (differenceMinites < 60) {
      return "$differenceMinites M";
    } else if (differenceHours < 24) {
      return "$differenceHours H";
    } else if (differenceInDays < 7) {
      return "$differenceInDays D";
    } else if (differenceInWeeks < 4) {
      return "$differenceInWeeks W";
    } else if (differenceInMonths < 12) {
      return "$differenceInMonths Mo";
    } else {
      if (differenceInMonths > 1 && differenceInYears > 1) {
        return "$differenceInYears ${yearPretty(differenceInYears)} , $differenceInMonths Month";
      } else {
        return yearPretty(differenceInYears);
      }
    }
  }

  String yearPretty(int value) {
    if (value == 1) {
      return "y";
    } else {
      return " $value y";
    }
  }
}

// class DistanceUtils {
//   final double value;
//   final DistanceUnitEnum valueUnit;

//   DistanceUtils({required this.value, this.valueUnit = DistanceUnitEnum.cm});

//   String prettyText([bool asShortcut = true]) {
//     if (toMil >= 1) {
//       return "$toMil\t${DistanceUnitEnum.mil.localizedName(asShortcut: asShortcut)}"
//           .replaceAll('.0', '');
//     } else if (toKm >= 1) {
//       return "$toKm\t${DistanceUnitEnum.km.localizedName(asShortcut: asShortcut)}"
//           .replaceAll('.0', '');
//     } else if (toM >= 1) {
//       return "$toM\t${DistanceUnitEnum.m.localizedName(asShortcut: asShortcut)}"
//           .replaceAll('.0', '');
//     } else {
//       return "$toCm\t${DistanceUnitEnum.cm.localizedName(asShortcut: asShortcut)}"
//           .replaceAll('.0', '');
//     }
//   }

//   double get toCm {
//     switch (valueUnit) {
//       case DistanceUnitEnum.m:
//         return value * 100;
//       case DistanceUnitEnum.km:
//         return value * 100000;
//       case DistanceUnitEnum.mil:
//         return value * 1000000;
//       case DistanceUnitEnum.cm:
//       default:
//         return value;
//     }
//   }

//   double get toM {
//     switch (valueUnit) {
//       case DistanceUnitEnum.m:
//         return value;
//       case DistanceUnitEnum.km:
//         return value * 1000;
//       case DistanceUnitEnum.mil:
//         return value * 1000;
//       case DistanceUnitEnum.cm:
//       default:
//         return value / 100;
//     }
//   }

//   double get toKm {
//     switch (valueUnit) {
//       case DistanceUnitEnum.m:
//         return value / 1000;
//       case DistanceUnitEnum.km:
//         return value;
//       case DistanceUnitEnum.mil:
//         return value / 1000;
//       case DistanceUnitEnum.cm:
//       default:
//         return value / 100000;
//     }
//   }

//   double get toMil {
//     switch (valueUnit) {
//       case DistanceUnitEnum.m:
//         return value / 1000000;
//       case DistanceUnitEnum.km:
//         return value * 1000;
//       case DistanceUnitEnum.mil:
//         return value;
//       case DistanceUnitEnum.cm:
//       default:
//         return value / 10000000;
//     }
//   }
// }

// enum DistanceUnitEnum {
//   cm,
//   m,
//   km,
//   mil;

//   AppLanguageEnum get _getLang => injector<LocalizationContainer>().getLang;

//   String localizedName({bool asShortcut = true}) {
//     final bool isArabic = _getLang == AppLanguageEnum.ar;
//     if (asShortcut && isArabic) {
//       return arNameShortcut;
//     } else if (asShortcut == false && isArabic) {
//       return arName;
//     } else if (asShortcut) {
//       return enNameShortcut;
//     } else {
//       return enName;
//     }
//   }

//   String get arNameShortcut {
//     switch (this) {
//       case DistanceUnitEnum.cm:
//         return 'سم';
//       case DistanceUnitEnum.m:
//         return 'م';
//       case DistanceUnitEnum.km:
//         return 'كم';
//       case DistanceUnitEnum.mil:
//         return 'ميل';
//     }
//   }

//   String get arName {
//     switch (this) {
//       case DistanceUnitEnum.cm:
//         return 'سنتيمتر';
//       case DistanceUnitEnum.m:
//         return 'متر';
//       case DistanceUnitEnum.km:
//         return 'كيلومتر';
//       case DistanceUnitEnum.mil:
//         return 'ميل';
//     }
//   }

//   String get enNameShortcut {
//     switch (this) {
//       case DistanceUnitEnum.cm:
//         return 'CM';
//       case DistanceUnitEnum.m:
//         return 'M';
//       case DistanceUnitEnum.km:
//         return 'KM';
//       case DistanceUnitEnum.mil:
//         return 'Mil';
//     }
//   }

//   String get enName {
//     switch (this) {
//       case DistanceUnitEnum.cm:
//         return 'Cintemeter';
//       case DistanceUnitEnum.m:
//         return 'Meter';
//       case DistanceUnitEnum.km:
//         return 'Kilometer';
//       case DistanceUnitEnum.mil:
//         return 'Mille';
//     }
//   }
// }
