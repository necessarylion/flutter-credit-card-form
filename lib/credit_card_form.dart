library credit_card_form;

import 'package:credit_card_form/text_input_widget.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'component.dart';
part 'theme.dart';

enum CardType {
  master,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  others,
  mir,
  invalid
}

class CreditCardController extends ChangeNotifier {
  CreditCardValue value = CreditCardValue();

  void setValue(CreditCardValue initialValue) {
    value = initialValue;
    notifyListeners();
  }
}

class CreditCardResult {
  final String cardNumber;
  final String cvc;
  final String cardHolderName;
  final String expirationMonth;
  final String expirationYear;
  final CardType? cardType;
  const CreditCardResult({
    required this.cardNumber,
    required this.cvc,
    required this.cardHolderName,
    required this.expirationMonth,
    required this.expirationYear,
    this.cardType,
  });
}

class CreditCardValue {
  String? cardNumber;
  String? cardHolderName;
  String? expiryDate;
  String? cvc;
  CreditCardValue({
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.cvc,
  });
}
