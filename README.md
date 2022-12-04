# Flutter Credit/Debit Card Form

### Preview

<img width="300" src="preview-dark.png" />
<img width="300" src="preview-light.png" />

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