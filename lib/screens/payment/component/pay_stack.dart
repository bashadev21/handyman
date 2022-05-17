import 'dart:io';

import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:nb_utils/nb_utils.dart';

class PayStackApi {
  PaystackPlugin payStackPlugin = PaystackPlugin();
  num totalAmount = 0;

  init({required String payStackPublicKey, required num totalAmount}) {
    payStackPlugin.initialize(publicKey: payStackPublicKey);
    this.totalAmount = totalAmount;
  }

  void payStackPayment(BuildContext context) async {
    String? _cardNumber;
    String? _cvv;
    int? _expiryMonth;
    int? _expiryYear;
    CheckoutMethod _method = CheckoutMethod.card;

    Charge charge = Charge()
      ..amount = totalAmount.toInt() // In base currency
      ..email = appStore.userEmail
      ..currency = "NGN"
      ..card = PaymentCard(number: _cardNumber, cvc: _cvv, expiryMonth: _expiryMonth, expiryYear: _expiryYear);

    charge.reference = _getReference();
    try {
      CheckoutResponse response = await payStackPlugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        hideEmail: true,
        logo: Image.asset(appLogo, height: 76, width: 76),
      ); //_updateStatus(response.reference, response.message);
      if (response.message == "Success") {
        // createNativeOrder(context, "PayStackPayment");
      } else {
        snackBar(context, title: "Payment Failed");
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }
}

PayStackApi payStackApi = PayStackApi();
