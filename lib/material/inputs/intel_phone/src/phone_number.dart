// ignore_for_file: must_be_immutable

part of '../phone_field.dart';

class NumberTooLongException implements Exception {}

class NumberTooShortException implements Exception {}

class InvalidCharactersException implements Exception {}

class IntelPhoneNumberEntity extends Equatable {
  String countryISOCode;
  String countryCode;
  String number;
  String? numberWithCode = '';
  int? numberMaxLength = 0;

  PhoneEntity get getPhoneEntity => PhoneEntity(code: countryCode, phone: number, isoCode: countryISOCode);

  IntelPhoneNumberEntity({required this.countryISOCode, required this.countryCode, this.number = '', this.numberMaxLength}) {
    if (number.isNotEmpty) {
      numberWithCode = "${countryCode.replaceAll("+", "")}$number";
    }
  }

  factory IntelPhoneNumberEntity.fromCompleteNumber({required String completeNumber}) {
    if (completeNumber == "") {
      return IntelPhoneNumberEntity(countryISOCode: "", countryCode: "", numberMaxLength: 40);
    }

    try {
      final PhoneFieldCountryEntity country = getCountry(completeNumber);
      String number;
      if (completeNumber.startsWith('+')) {
        number = completeNumber.substring(1 + country.dialCode.length + country.regionCode.length);
      } else {
        number = completeNumber.substring(country.dialCode.length + country.regionCode.length);
      }
      return IntelPhoneNumberEntity(
        countryISOCode: country.code,
        countryCode: country.dialCode + country.regionCode,
        numberMaxLength: country.maxLength,
        number: number,
      );
    } on InvalidCharactersException {
      rethrow;
    } on Exception {
      return IntelPhoneNumberEntity(countryISOCode: "", countryCode: "", numberMaxLength: 40);
    }
  }

  bool isValidNumber() {
    final PhoneFieldCountryEntity country = getCountry(completeNumber);
    if (number.length < country.minLength) {
      throw NumberTooShortException();
    }

    if (number.length > country.maxLength) {
      throw NumberTooLongException();
    }
    return true;
  }

  String get completeNumber {
    return countryCode + number;
  }

  static PhoneFieldCountryEntity getCountry(String phoneNumber) {
    if (phoneNumber == "") {
      throw NumberTooShortException();
    }

    final validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validPhoneNumber.hasMatch(phoneNumber)) {
      throw InvalidCharactersException();
    }

    if (phoneNumber.startsWith('+')) {
      return _countries.firstWhere((country) => phoneNumber.substring(1).startsWith(country.dialCode + country.regionCode));
    }
    return _countries.firstWhere((country) => phoneNumber.startsWith(country.dialCode + country.regionCode));
  }

  @override
  String toString() => 'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';

  @override
  List<Object?> get props => [countryISOCode, countryCode, number, numberMaxLength, numberWithCode];
}
