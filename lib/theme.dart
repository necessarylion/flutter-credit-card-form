part of credit_card_form;

class CreditCardDarkTheme implements CreditCardTheme {
  @override
  Color backgroundColor = HexColor('181E28');
  @override
  Color textColor = HexColor('FFFFFF');
  @override
  Color borderColor = HexColor('232C3B');
  @override
  Color labelColor = HexColor('41546F');
}

class CreditCardLightTheme implements CreditCardTheme {
  @override
  Color backgroundColor = HexColor('F9F9F9');
  @override
  Color textColor = HexColor('242424');
  @override
  Color borderColor = HexColor('e8e8f6');
  @override
  Color labelColor = Colors.black45;
}

abstract class CreditCardTheme {
  late Color backgroundColor;
  late Color textColor;
  late Color borderColor;
  late Color labelColor;
}
