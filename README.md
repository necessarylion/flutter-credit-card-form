# Flutter Credit/Debit Card Form

### Preview

<img height="500" src="https://raw.githubusercontent.com/necessarylion/flutter-credit-card-form/master/preview-dark.png" /> <img height="500" src="https://raw.githubusercontent.com/necessarylion/flutter-credit-card-form/master/preview-light.png" />

### Usage

```dart
CreditCardForm(
    theme: CreditCardLightTheme(),
    onChanged: (CreditCardResult result) {
        print(result.cardNumber);
        print(result.cardHolderName);
        print(result.expirationMonth);
        print(result.expirationYear);
        print(result.cardType);
        print(result.cvc);
    },
),
```

| Param                | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `theme`              | card theme `CreditCardLightTheme()` or `CreditCardDarkTheme` |
| `onChanged` required | listen for input values changed                              |
| `cardNumberLabel`    | label for card number input                                  |
| `cardHolderLabel`    | label for card holder name input                             |
| `hideCardHolder`     | default (false)                                              |
| `expiredDateLabel`   | label for expired date input                                 |
| `cvcLabel`           | label for security code                                      |
| `cardNumberLength`   | length for card number. default (16)                         |
| `cvcLength`          | length for security code. default (4)                        |
| `cvcIcon`            | Icon widget for security code.                               |
| `fontSize`           | font size for all inputs and labels. default (16)            |
| `controller`         | `CreditCardController()` to set initial value to inputs      |

### Set Credit Card Value Initially

```dart
CreditCardController controller = CreditCardController();

CreditCardForm(
    controller: controller,
    onChanged: (CreditCardResult result) {
    },
),

controller.setValue(CreditCardValue(
    cardNumber: '4242 4242 4242 4242',
    cardHolderName: 'John Wick',
    expiryDate: '08/25',
));

```

### How to create custom theme

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
    onChanged: (CreditCardResult result) {
    },
),
```

### Development
Want to contribute? Great! Fork the repo and create PR to us.
