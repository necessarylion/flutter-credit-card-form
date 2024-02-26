part of credit_card_form;

class CreditCardForm extends StatefulWidget {
  final String? cardNumberLabel;
  final String? cardHolderLabel;
  final bool? hideCardHolder;
  final String? expiredDateLabel;
  final String? cvcLabel;
  final Widget? cvcIcon;
  final int? cardNumberLength;
  final int? cvcLength;
  final double fontSize;
  final CreditCardTheme? theme;
  final Function(CreditCardResult) onChanged;
  final CreditCardController? controller;
  final double? spaceBetween;
  const CreditCardForm({
    super.key,
    this.theme,
    required this.onChanged,
    this.cardNumberLabel,
    this.cardHolderLabel,
    this.hideCardHolder = false,
    this.expiredDateLabel,
    this.cvcLabel,
    this.cvcIcon,
    this.cardNumberLength = 16,
    this.cvcLength = 4,
    this.fontSize = 16,
    this.controller,
    this.spaceBetween = 10,
  });

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  Map<String, dynamic> params = {
    "card": '',
    "expired_date": '',
    "card_holder_name": '',
    "cvc": '',
  };

  Map cardImg = {
    "img": 'credit_card.png',
    "width": 30.0,
  };

  Map<String, TextEditingController> controllers = {
    "card": TextEditingController(),
    "expired_date": TextEditingController(),
    "card_holder_name": TextEditingController(),
    "cvc": TextEditingController(),
  };

  String error = '';

  CardType? cardType;

  @override
  void dispose() {
    controllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  void initState() {
    handleController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CreditCardTheme theme = widget.theme ?? CreditCardLightTheme();
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(color: theme.borderColor, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: AutofillGroup(
        child: Column(
          children: [
            TextInputWidget(
              theme: theme,
              fontSize: widget.fontSize,
              controller: controllers['card'],
              label: widget.cardNumberLabel ?? 'Card number',
              bottom: 1,
              autofillHint: const [AutofillHints.creditCardNumber],
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.cardNumberLength),
                CardNumberInputFormatter(),
              ],
              onChanged: (val) {
                Map img = CardUtils.getCardIcon(val);
                CardType type =
                    CardUtils.getCardTypeFrmNumber(val.replaceAll(' ', ''));
                setState(() {
                  cardImg = img;
                  cardType = type;
                  params['card'] = val;
                });
                emitResult();
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'images/${cardImg['img']}',
                  package: 'credit_card_form',
                  width: cardImg['width'] as double?,
                ),
              ),
            ),
            SizedBox(
              height: widget.spaceBetween,
            ),
            if (widget.hideCardHolder == false) ...[
              TextInputWidget(
                theme: theme,
                fontSize: widget.fontSize,
                label: widget.cardHolderLabel ?? 'Card holder name',
                controller: controllers['card_holder_name'],
                autofillHint: const [AutofillHints.creditCardName],
                bottom: 1,
                onChanged: (val) {
                  setState(() {
                    params['card_holder_name'] = val;
                  });
                  emitResult();
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: widget.spaceBetween,
              ),
            ],
            Row(
              children: [
                Expanded(
                  child: TextInputWidget(
                    theme: theme,
                    fontSize: widget.fontSize,
                    label: widget.expiredDateLabel ?? 'MM/YY',
                    right: 1,
                    onChanged: (val) {
                      setState(() {
                        params['expired_date'] = val;
                      });
                      emitResult();
                    },
                    controller: controllers['expired_date'],
                    autofillHint: const [
                      AutofillHints.creditCardExpirationDate
                    ],
                    formatters: [
                      CardExpirationFormatter(),
                      LengthLimitingTextInputFormatter(5)
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                Expanded(
                  child: TextInputWidget(
                    theme: theme,
                    fontSize: widget.fontSize,
                    label: widget.cvcLabel ?? 'CVC',
                    controller: controllers['cvc'],
                    password: true,
                    onChanged: (val) {
                      setState(() {
                        params['cvc'] = val;
                      });
                      emitResult();
                    },
                    autofillHint: const [AutofillHints.creditCardSecurityCode],
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(widget.cvcLength)
                    ],
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8),
                      child: widget.cvcIcon ??
                          Image.asset(
                            'images/cvc.png',
                            package: 'credit_card_form',
                            height: 25,
                          ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  emitResult() {
    List res = params['expired_date'].split('/');
    CreditCardResult result = CreditCardResult(
      cardNumber: params['card'].replaceAll(' ', ''),
      cvc: params['cvc'],
      cardHolderName: params['card_holder_name'],
      expirationMonth: res[0] ?? '',
      expirationYear: res.asMap().containsKey(1) ? res[1] : '',
      cardType: cardType,
    );
    widget.onChanged(result);
  }

  handleController() {
    if (widget.controller != null) {
      widget.controller?.addListener(() {
        CreditCardValue? initialValue = widget.controller?.value;
        if (initialValue?.cardNumber != null) {
          TextEditingValue cardNumber =
              FilteringTextInputFormatter.digitsOnly.formatEditUpdate(
            const TextEditingValue(text: ''),
            TextEditingValue(text: initialValue!.cardNumber.toString()),
          );

          cardNumber = LengthLimitingTextInputFormatter(19).formatEditUpdate(
            const TextEditingValue(text: ''),
            TextEditingValue(text: cardNumber.text),
          );

          cardNumber = CardNumberInputFormatter().formatEditUpdate(
            const TextEditingValue(text: ''),
            TextEditingValue(text: cardNumber.text),
          );

          controllers['card']?.value = cardNumber;
        }
        if (initialValue?.cardHolderName != null) {
          controllers['card_holder_name']?.text =
              initialValue!.cardHolderName.toString();
        }
        if (initialValue?.expiryDate != null) {
          controllers['expired_date']?.value =
              CardExpirationFormatter().formatEditUpdate(
            const TextEditingValue(text: ''),
            TextEditingValue(text: initialValue!.expiryDate.toString()),
          );
        }
      });
    }
  }
}
