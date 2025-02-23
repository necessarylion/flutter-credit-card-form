part of credit_card_form;

class CreditCardController extends ChangeNotifier {
  CardData value = CardData();

  void setValue(CardData initialValue) {
    value = initialValue;
    notifyListeners();
  }
}

class CardData {
  String cardNumber;
  String expiredDate;
  String cardHolderName;
  String cvc;
  CardType? cardType;

  CardData({
    this.cardNumber = '',
    this.expiredDate = '',
    this.cardHolderName = '',
    this.cvc = '',
    this.cardType,
  }) {
    // remove all spaces
    cardNumber = cardNumber.replaceAll(' ', '');
  }

  // get expired month
  String get expiredMonth {
    if (expiredDate.isEmpty) return '';
    List<String> year = expiredDate.split('/');
    if (year.isNotEmpty) return year[0];
    return '';
  }

  // get expired year
  String get expiredYear {
    if (expiredDate.isEmpty) return '';
    List<String> year = expiredDate.split('/');
    if (year.length > 1) return year[1];
    return '';
  }
}

class CardDataInputController extends ChangeNotifier {
  TextEditingController cardNumber;
  TextEditingController expiredDate;
  TextEditingController cardHolderName;
  TextEditingController cvc;

  CardDataInputController({
    TextEditingController? cardNumber,
    TextEditingController? expiredDate,
    TextEditingController? cardHolderName,
    TextEditingController? cvc,
  })  : cardNumber = cardNumber ?? TextEditingController(),
        expiredDate = expiredDate ?? TextEditingController(),
        cardHolderName = cardHolderName ?? TextEditingController(),
        cvc = cvc ?? TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cardNumber.dispose();
    expiredDate.dispose();
    cardHolderName.dispose();
    cvc.dispose();
  }

  void set(CardData data) {
    // format to text only
    TextEditingValue formattedCardNumber =
        FilteringTextInputFormatter.digitsOnly.formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(text: data.cardNumber.toString()),
    );

    // limit to 19 digits
    formattedCardNumber = LengthLimitingTextInputFormatter(19).formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(text: formattedCardNumber.text),
    );

    // format to card number
    formattedCardNumber = CardNumberInputFormatter().formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(text: formattedCardNumber.text),
    );

    cardNumber.text = formattedCardNumber.text;

    // expired date
    expiredDate.value = CardExpirationFormatter().formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(text: data.expiredDate.toString()),
    );

    // card holder name
    cardHolderName.text = data.cardHolderName;

    // cvc
    cvc.text = data.cvc;
  }

  get value {
    return CardData(
      cardNumber: cardNumber.text,
      expiredDate: expiredDate.text,
      cardHolderName: cardHolderName.text,
      cvc: cvc.text,
      cardType: CardUtils.getCardTypeFrmNumber(cardNumber.text),
    );
  }
}

class CardImage {
  final String img;
  final double width;

  const CardImage({
    this.img = 'credit_card.png',
    this.width = 30.0,
  });

  Widget render() {
    return Image.asset(
      'images/$img',
      package: 'credit_card_form',
      width: width,
    );
  }
}
