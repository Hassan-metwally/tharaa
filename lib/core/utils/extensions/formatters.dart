part of core;

/// [UpperCaseTextFormatter] Only Allow First Character In Upper Case
/// Make Any Character in Small Case Else First
/// If Want To Capitalize Only First Without Affect Other Letters Use [CapitalizeFirstInputFormatter]
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: capitalize(newValue.text), selection: newValue.selection);
  }

  String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }
}

/// [CapitalizeFirstInputFormatter] Only Capitalize First Character In Text
class CapitalizeFirstInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.trimLeft();
    if (text.isNotEmpty) {
      final formattedText = text.replaceAllMapped(RegExp(r"(^\w)"), (match) => match.group(0)!.toUpperCase());

      final newTextLength = formattedText.length;
      final selection = newValue.selection.copyWith(
        baseOffset: newValue.selection.baseOffset.clamp(0, newTextLength),
        extentOffset: newValue.selection.extentOffset.clamp(0, newTextLength),
      );
      return TextEditingValue(text: formattedText, selection: selection);
    }
    return newValue;
  }
}

class EnglishNumbersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.convertArabicNumbersToEnglish,
      composing: newValue.composing,
      selection: newValue.selection,
    );
  }
}

/// [NoStartWithSpaceFormatter] This Formatter Deny Spaces All Over Text
/// If Want To Oly Deny First Space Use [NoLeadingSpaceFormatter]
class NoStartWithSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && newValue.text.startsWith(' ')) {
      return oldValue.copyWith(
        text: newValue.text.trimLeft(),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset - 1,
          extentOffset: newValue.selection.extentOffset - 1,
        ),
      );
    }
    return newValue;
  }
}

class NoContainSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ') || newValue.text.endsWith(' ')) {
      final String trimmedText = newValue.text.trim();

      return TextEditingValue(text: trimmedText, selection: newValue.selection, composing: newValue.composing);
    }
    return newValue;
  }
}

class AlwaysLowerCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String text = newValue.text.toLowerCase();

    return TextEditingValue(text: text, selection: newValue.selection);
  }
}

/// [OnlyArabicInputFormatter] Only accept arabic characters
class OnlyArabicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only Arabic letters and at most one space between letters
    final filteredValue = newValue.text
        .replaceAll(RegExp(r'[^\u0621-\u064A ]'), '') // Allow only Arabic letters and spaces
        .replaceAll(RegExp(r'\s+'), ' '); // Replace consecutive spaces with a single space

    // Ensure that only one space is present between letters
    final formattedValue = filteredValue
        .split(' ')
        .map((word) {
          return word.replaceAll("ـ", "").trim();
        })
        .join(' ');

    // Ensure the start position of the selection range is within the valid range
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, formattedValue.length),
      extentOffset: newValue.selection.extentOffset.clamp(0, formattedValue.length),
    );

    return TextEditingValue(text: formattedValue, selection: selection, composing: newValue.composing);
  }
}

/// Allow Any Characters Else English [Dont Allow English]
class DenyEnglishLettersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[a-zA-Z]'), '');

    if (filteredText.isNotEmpty && filteredText[0] == ' ') {
      filteredText = filteredText.trimLeft();
    }

    if (filteredText.startsWith('\n')) {
      filteredText = filteredText.replaceFirst('\n', '');
    }
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, filteredText.length),
      extentOffset: newValue.selection.extentOffset.clamp(0, filteredText.length),
    );

    return TextEditingValue(text: filteredText, selection: selection);
  }
}

class DenyArabicLettersInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^\x00-\x7F]'), '');

    if (filteredText.isNotEmpty && filteredText[0] == ' ') {
      filteredText = filteredText.trimLeft();
    }

    if (filteredText.startsWith('\n')) {
      filteredText = filteredText.replaceFirst('\n', '');
    }
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, filteredText.length),
      extentOffset: newValue.selection.extentOffset.clamp(0, filteredText.length),
    );

    return TextEditingValue(text: filteredText, selection: selection);
  }
}

class OnlyEnglishLettersInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only English letters and at most one space between letters
    final filteredValue = newValue.text
        .replaceAll(RegExp(r'[^a-zA-Z ]'), '') // Allow only English letters and spaces
        .replaceAll(RegExp(r'\s+'), ' '); // Replace consecutive spaces with a single space

    // Ensure that only one space is present between letters
    final formattedValue = filteredValue.split(' ').map((word) => word.trim()).join(' ');

    // Ensure the start position of the selection range is within the valid range
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, formattedValue.length),
      extentOffset: newValue.selection.extentOffset.clamp(0, formattedValue.length),
    );

    return TextEditingValue(text: formattedValue, selection: selection, composing: newValue.composing);
  }
}

class NoNumbersTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Deny input of numbers in Arabic and English
    String filteredValue = newValue.text.replaceAll(RegExp(r'[0-9]'), '');
    filteredValue = newValue.text.replaceAll(RegExp(r'[٠-٩]'), '');
    // Ensure the start position of the selection range is within the valid range
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, filteredValue.length),
      extentOffset: newValue.selection.extentOffset.clamp(0, filteredValue.length),
    );

    return TextEditingValue(text: filteredValue, selection: selection, composing: newValue.composing);
  }
}

class OnlyArabicEnglishInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^\u0621-\u064Aa-zA-Z ]'), '').replaceAll(RegExp(r'\s+'), ' ');

    final formattedValue = filteredValue.split(' ').map((word) => word.trim()).join(' ');

    final newTextLength = formattedValue.length;
    final selection = newValue.selection.copyWith(
      baseOffset: newValue.selection.baseOffset.clamp(0, newTextLength),
      extentOffset: newValue.selection.extentOffset.clamp(0, newTextLength),
    );

    return TextEditingValue(text: formattedValue, selection: selection);
  }
}

class LengthSplitterFormatter extends TextInputFormatter {
  final int groupLength;

  LengthSplitterFormatter({required this.groupLength});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all spaces
    final String filtered = newValue.text.replaceAll(' ', '');

    // Split the text into groups of specified length
    String formatted = '';
    for (int i = 0; i < filtered.length; i++) {
      if (i > 0 && i % groupLength == 0) {
        formatted += ' ';
      }
      formatted += filtered[i];
    }

    // Maintain cursor position
    final int cursorPosition = formatted.length - (filtered.length - newValue.selection.baseOffset);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition.clamp(0, formatted.length)),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final intel.NumberFormat currencyFormat = intel.NumberFormat("#,###", "ar");
  final String currencySuffix = "appLocalizer.ryal";

  CurrencyInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String oldRaw = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String newRaw = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Remove leading zeros if more than 1 digit
    final bool wasZero = oldRaw == '0' || oldRaw == '00';
    if (wasZero && newRaw.length > 1 && newRaw.startsWith('0')) {
      newRaw = newRaw.replaceFirst(RegExp(r'^0+'), '');
    }

    if (newRaw.isEmpty) newRaw = '0';

    final int number = int.tryParse(newRaw) ?? 0;
    final String formattedNumber = currencyFormat.format(number);
    final String finalText = '$formattedNumber $currencySuffix';

    // 🛠 Fix for cursor misplacement when number is 0
    if (newRaw == '0' || newRaw == '00') {
      final int offset = finalText.indexOf(RegExp(r'[0-9]')) + 1;
      return TextEditingValue(
        text: finalText,
        selection: TextSelection.collapsed(offset: offset),
      );
    }

    // 🧠 Smart cursor offset for other cases
    final int newCursorOffset = _calculateCursorOffset(oldValue, newValue, formattedNumber);

    return TextEditingValue(
      text: finalText,
      selection: TextSelection.collapsed(offset: newCursorOffset),
    );
  }

  int _calculateCursorOffset(TextEditingValue oldValue, TextEditingValue newValue, String formattedNumber) {
    int rawCursorIndex = newValue.selection.baseOffset;
    rawCursorIndex = rawCursorIndex.clamp(0, newValue.text.length);

    int digitCountBeforeCursor = 0;
    for (int i = 0; i < rawCursorIndex; i++) {
      if (RegExp(r'[0-9]').hasMatch(newValue.text[i])) {
        digitCountBeforeCursor++;
      }
    }

    int cursorInFormatted = 0;
    int digitsSeen = 0;
    while (cursorInFormatted < formattedNumber.length && digitsSeen < digitCountBeforeCursor) {
      if (RegExp(r'[0-9]').hasMatch(formattedNumber[cursorInFormatted])) {
        digitsSeen++;
      }
      cursorInFormatted++;
    }

    return cursorInFormatted;
  }
}
