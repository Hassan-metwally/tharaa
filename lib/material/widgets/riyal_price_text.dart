import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

/// Dont forget to add the font to pubspec
///
/// - family: Riyal
///   fonts:
///     - asset: assets/fonts/riyal.ttf
///

const IconData saudiRiyalSymbolIconData = IconData(0xe800, fontFamily: 'Riyal');

class RiyalPriceText extends StatelessWidget {
  final String price;
  final TextStyle? priceTextStyle;
  final TextStyle? currencyTextStyle;
  final TextAlign textAlign;

  const RiyalPriceText({super.key, required this.price, this.priceTextStyle, this.currencyTextStyle, this.textAlign = TextAlign.start});

  bool checkIfPriceOnly() {
    final regx = RegExp(r'(\d+\.\d+)');
    return regx.hasMatch(price);
  }

  String getPrice() {
    if (checkIfPriceOnly()) {
      return intl.NumberFormat('###,###.0#', 'en_US').format(double.parse(price));
    } else {
      final newPrice = price.split(' ').firstOrNull ?? '';
      if (newPrice.isEmpty) {
        return '';
      }
      return intl.NumberFormat('###,###.0#', 'en_US').format(double.parse(newPrice));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyStyle =
        currencyTextStyle?.copyWith(fontFamily: saudiRiyalSymbolIconData.fontFamily) ??
        priceTextStyle?.copyWith(fontFamily: saudiRiyalSymbolIconData.fontFamily) ??
        TextStyle(fontFamily: saudiRiyalSymbolIconData.fontFamily);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${getPrice()} ', style: priceTextStyle),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Text(String.fromCharCode(saudiRiyalSymbolIconData.codePoint), style: currencyStyle),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}

extension RiyalPrice on Text {
  Widget withRiyalPrice() {
    return RiyalPriceText(price: data.toString(), priceTextStyle: style, currencyTextStyle: style);
  }
}
