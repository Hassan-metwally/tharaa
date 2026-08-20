part of core;

enum AppLanguageEnum {
  ar(value: "ar", countryCode: "EG"),
  en(value: "en", countryCode: "US");

  final String value;
  final String countryCode;

  const AppLanguageEnum({required this.value, required this.countryCode});

  factory AppLanguageEnum.fromLanguageCode(String languageCode) {
    return AppLanguageEnum.values.firstWhere(
      (element) => element.value.toLowerCase() == languageCode.toLowerCase(),
      orElse: () => AppLanguageEnum.ar,
    );
  }

  Locale get local => Locale(value.toLowerCase());

  String get localCountryCode => "$value-$countryCode";

  Map<String, dynamic> get toMap => {"value": value, "countryCode": countryCode};

  String get toJson => json.encode(toMap);

  factory AppLanguageEnum.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    final String? value = encodedMap["value"]?.toLowerCase();
    final String? countryCode = encodedMap["countryCode"]?.toLowerCase();

    return AppLanguageEnum.values.firstWhere(
      (element) => element.value.toLowerCase() == value && element.countryCode.toLowerCase() == countryCode,
    );
  }
}
