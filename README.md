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

- Available themes are `CreditCardLightTheme()` and `CreditCardDarkTheme()`