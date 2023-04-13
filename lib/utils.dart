import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/services.dart';

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardUtils {
  static Map getCardIcon(input) {
    CardType cardType =
        CardUtils.getCardTypeFrmNumber(input.replaceAll(' ', ''));
    String img = "";
    double imgWidth = 30.0;
    switch (cardType) {
      case CardType.master:
        img = 'brand_mastercard.png';
        imgWidth = 40.0;
        break;
      case CardType.visa:
        img = 'brand_visa.png';
        imgWidth = 40.0;
        break;
      case CardType.americanExpress:
        img = 'brand_amex.png';
        imgWidth = 40.0;
        break;
      case CardType.discover:
        img = 'brand_discover.png';
        imgWidth = 60.0;
        break;
      case CardType.dinersClub:
        img = 'brand_diners.png';
        imgWidth = 40.0;
        break;
      case CardType.jcb:
        img = 'brand_jcb.png';
        imgWidth = 40.0;
        break;
      case CardType.mir:
        img = 'brand_mir.png';
        imgWidth = 50.0;
        break;
      case CardType.others:
        img = 'credit_card.png';
        break;
      default:
        img = 'credit_card.png';
        break;
    }
    return {"img": img, "width": imgWidth};
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.americanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.dinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.jcb;
    } else if (input.startsWith(RegExp(r'(220[0-4])'))) {
      cardType = CardType.mir;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}
