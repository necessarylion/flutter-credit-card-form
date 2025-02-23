part of credit_card_form;

class ScannerButton extends StatelessWidget {
  final CardDataInputController controller;

  final CardScanOptions? scanOptions;

  final Widget? scannerIcon;

  final Function(CardData) onChanged;

  const ScannerButton({
    super.key,
    required this.controller,
    required this.onChanged,
    this.scanOptions,
    this.scannerIcon,
  });

  void onTap() async {
    CardDetails? cardDetails = await CardScanner.scanCard(
      scanOptions: scanOptions ??
          const CardScanOptions(
            scanExpiryDate: true,
            cardScannerTimeOut: 3000,
            enableLuhnCheck: false,
            considerPastDatesInExpiryDateScan: true,
          ),
    );
    if (cardDetails != null) {
      controller.set(CardData(
        cardNumber: cardDetails.cardNumber,
        cardHolderName: cardDetails.cardHolderName,
        expiredDate: cardDetails.expiryDate,
      ));
      onChanged(controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: scannerIcon ??
          Image.asset(
            'images/scanner.png',
            package: 'credit_card_form',
            width: 30.0,
          ),
    );
  }
}
