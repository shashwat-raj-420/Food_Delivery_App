import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/pages/delivery_progess_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    Color textColor = Theme.of(context).colorScheme.inversePrimary;
    if (formKey.currentState!.validate()) {
      // only show dialog if form is valid
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(
                "Confirm Payment",
                style: TextStyle(color: textColor),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      "Card Number: $cardNumber",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Expiry Date: $expiryDate",
                      style: TextStyle(color: textColor),
                    ),
                    Text(
                      "Card Holder Name: $cardHolderName",
                      style: TextStyle(color: textColor),
                    ),
                    Text("CVV: $cvvCode", style: TextStyle(color: textColor)),
                  ],
                ),
              ),
              actions: [
                // cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel"),
                ),
                // yes button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveryProgressPage(),
                      ),
                    );
                  },
                  child: const Text("yes"),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("error", style: TextStyle(color: textColor)),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cardDetailsColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          // credit card
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            onCreditCardWidgetChange: (p0) {},
          ),

          // credit card form
          CreditCardForm(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (data) {
              setState(() {
                cardNumber = data.cardNumber;
                cardHolderName = data.cardHolderName;
                expiryDate = data.expiryDate;
                cvvCode = data.cvvCode;
              });
            },
            formKey: formKey,
            inputConfiguration: InputConfiguration(
              cardHolderDecoration: InputDecoration(
                labelText: "Card Holder",
                labelStyle: TextStyle(color: cardDetailsColor),
              ),
              cardHolderTextStyle: TextStyle(color: cardDetailsColor),
              cardNumberDecoration: InputDecoration(
                hintText: "XXXX XXXX XXXX XXXX",
                hintStyle: TextStyle(color: cardDetailsColor),
                labelText: "Card Number",
                labelStyle: TextStyle(color: cardDetailsColor),
              ),
              cardNumberTextStyle: TextStyle(color: cardDetailsColor),
              expiryDateDecoration: InputDecoration(
                hintText: "MM/YY",
                hintStyle: TextStyle(color: cardDetailsColor),
                labelText: "Expiry Date",
                labelStyle: TextStyle(color: cardDetailsColor),
              ),
              expiryDateTextStyle: TextStyle(color: cardDetailsColor),
              cvvCodeDecoration: InputDecoration(
                hintText: "XXX",
                hintStyle: TextStyle(color: cardDetailsColor),
                labelText: "CVV",
                labelStyle: TextStyle(color: cardDetailsColor),
              ),
              cvvCodeTextStyle: TextStyle(color: cardDetailsColor),
            ),
          ),

          const Spacer(),

          MyButton(onTap: () => userTappedPay(), text: "Pay now"),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
