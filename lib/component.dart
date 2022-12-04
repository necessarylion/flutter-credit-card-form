part of credit_card_form;

class CreditCardForm extends StatefulWidget {
  final String? cardNumberLabel;
  final String? cardHolderLabel;
  final String? expiredDateLabel;
  final String? cvcLabel;
  final double fontSize;
  final CreditCardTheme? theme;
  final Function(CreditCardResult) onChanged;
  const CreditCardForm({
    super.key,
    this.theme,
    required this.onChanged,
    this.cardNumberLabel,
    this.cardHolderLabel,
    this.expiredDateLabel,
    this.cvcLabel,
    this.fontSize = 16,
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

  String error = '';

  CardType? cardType;

  Map<String, TextEditingController> controllers = {
    "card": TextEditingController(),
    "expired_date": TextEditingController(),
    "card_holder_name": TextEditingController(),
    "cvc": TextEditingController(),
  };

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
      child: Column(
        children: [
          textInput(
            controller: controllers['card'],
            label: widget.cardNumberLabel ?? 'Card number',
            key: 'card',
            bottom: 1,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberInputFormatter(),
            ],
            onChanged: (val) {
              Map img = CardUtils.getCardIcon(val);
              CardType type =
                  CardUtils.getCardTypeFrmNumber(val.replaceAll(' ', ''));
              setState(() {
                cardImg = img;
                cardType = type;
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
          textInput(
            label: widget.cardHolderLabel ?? 'Card holder name',
            controller: controllers['card_holder_name'],
            key: 'card_holder_name',
            bottom: 1,
            onChanged: (val) {
              emitResult();
            },
            keyboardType: TextInputType.name,
          ),
          Row(
            children: [
              Expanded(
                child: textInput(
                  label: widget.expiredDateLabel ?? 'MM/YY',
                  right: 1,
                  key: 'expired_date',
                  onChanged: (val) {
                    emitResult();
                  },
                  controller: controllers['expired_date'],
                  formatters: [CardExpirationFormatter()],
                ),
              ),
              Expanded(
                child: textInput(
                  label: widget.cvcLabel ?? 'CVC',
                  key: 'cvc',
                  controller: controllers['cvc'],
                  password: true,
                  onChanged: (val) {
                    emitResult();
                  },
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
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
    );
  }

  @override
  void dispose() {
    controllers.forEach((key, value) => value.dispose());
    super.dispose();
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

  Widget textInput({
    required String label,
    required String key,
    double left = 0,
    double right = 0,
    double bottom = 0,
    double top = 0,
    List<TextInputFormatter>? formatters,
    TextInputType? keyboardType,
    bool? password,
    Function(String)? onChanged,
    Widget? suffixIcon,
    TextEditingController? controller,
  }) {
    CreditCardTheme theme = widget.theme ?? CreditCardLightTheme();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: left > 0 ? theme.borderColor : Colors.transparent,
            width: left,
          ),
          right: BorderSide(
            color: right > 0 ? theme.borderColor : Colors.transparent,
            width: right,
          ),
          top: BorderSide(
            color: top > 0 ? theme.borderColor : Colors.transparent,
            width: top,
          ),
          bottom: BorderSide(
            color: bottom > 0 ? theme.borderColor : Colors.transparent,
            width: bottom,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: theme.textColor,
          fontSize: widget.fontSize,
        ),
        onChanged: (value) {
          setState(() {
            params[key] = value;
          });
          if (onChanged != null) {
            onChanged(value);
          }
        },
        obscureText: password ?? false,
        inputFormatters: formatters ?? [],
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(15),
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            color: theme.labelColor,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }
}
