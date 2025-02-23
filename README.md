# Flutter Credit/Debit Card Form

## Features

- [x] Scan card with camera
- [x] Set value programmatically
- [x] Create custom theme
- [x] Listen for input values changed
- [x] Show card type icon

## Preview

<img height="500" src="https://raw.githubusercontent.com/necessarylion/flutter-credit-card-form/master/preview-dark.png" /> <img height="500" src="https://raw.githubusercontent.com/necessarylion/flutter-credit-card-form/master/preview-light.png" />

## Usage

```dart
import 'package:credit_card_form/credit_card_form.dart';

...

CardDataInputController controller = CardDataInputController();

CreditCardForm(
    theme: CreditCardLightTheme(),
    controller: controller,
    onChanged: (CardData data) {
        print(data.cardNumber);
        print(data.cardHolderName);
        print(data.expiredDate);
        print(data.expiredMonth);
        print(data.expiredYear);
        print(data.cardType);
        print(data.cvc);
    },
),
```

| Param                | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `theme`              | card theme `CreditCardLightTheme()` or `CreditCardDarkTheme` |
| `onChanged`(required)| listen for input values changed                              |
| `cardNumberLabel`    | label for card number input                                  |
| `cardHolderLabel`    | label for card holder name input                             |
| `hideCardHolder`     | default (false)                                              |
| `expiredDateLabel`   | label for expired date input                                 |
| `cvcLabel`           | label for security code                                      |
| `cardNumberLength`   | length for card number. default (16)                         |
| `cvcLength`          | length for security code. default (4)                        |
| `cvcIcon`            | Icon widget for security code.                               |
| `fontSize`           | font size for all inputs and labels. default (16)            |
| `controller`         | `CardDataInputController()`                                  |
| `enableScanner`      | default (false), If set to true, please sure sure you have given camera permission in android and ios|
| `scannerIcon`        | Icon widget for scanner button.                              |

Note: For more information about enabling scanner, please refer to [Card Scanner Package](https://pub.dev/packages/card_scanner)

## Set Credit Card Value Programmatically

```dart
CardDataInputController controller = CardDataInputController();

controller.set = CardData(
    cardNumber: '4242424242424242',
    cardHolderName: 'Zin Kyaw Kyaw',
    expiredDate: '11/23',
    cvc: '123',
);
```

## How to create custom theme

```dart
class CustomCardTheme implements CreditCardTheme {
  @override
  Color backgroundColor = Colors.white;
  @override
  Color textColor = Colors.black;
  @override
  Color borderColor = Colors.black45;
  @override
  Color labelColor = Colors.black45;
}

CreditCardForm(
    theme: CustomCardTheme(),
    onChanged: (CardData data) {
    },
),
```

## Development

Want to contribute? Great! Fork the repo and create PR to us.
