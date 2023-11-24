import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';


class PayStackPaymentSystem extends StatefulWidget {
  const PayStackPaymentSystem({Key? key}) : super(key: key);

  @override
  State<PayStackPaymentSystem> createState() => _PayStackPaymentSystemState();
}

class _PayStackPaymentSystemState extends State<PayStackPaymentSystem> {

  var publicKey = '[YOUR_PAYSTACK_PUBLIC_KEY]';
  final plugin = PaystackPlugin();

  //initialize the Paystack
  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  //When making payments with this plugin, there are 2 ways:
  //Check out(recommended), and.. Charge Card

  //implement the checkout function
  Future<void> checkOut() async {
    Charge charge = Charge()
      ..amount = 10000
      //..reference = _getReference()
    ..reference = 'Your reference transaction' // this is a placeholder for the above
      ..email = 'lottanna47@gmail.com';

    CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge);

    if(response.status == true){
      //Payment Successful, then proceed to order fulfillment
      print('Payment Successful');
    } else {
      //payment failed
      print('Payment failed: ${response.message}');
    }
  }

  //For The Charge Card
  PaymentCard _getCardFromUI(){
    return PaymentCard(
        number: 'CardNumberHere',
        cvc: 'Cardcvc',
        expiryMonth: 0,
        expiryYear: 0);
  }

  _chargeCard(String accessCode) async {
    var charge = Charge()
        ..accessCode = "accessCode"
        ..card = _getCardFromUI();
    final response = await plugin.chargeCard(
        context,
        charge: charge);
  }



 @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
