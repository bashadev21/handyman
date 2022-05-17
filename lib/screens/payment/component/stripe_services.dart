import 'dart:io';

import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/model/stripe_pay_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:booking_system_flutter/screens/payment/component/razor_pay_services.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class StripeServices {
  static late BookingDetailResponse bookDetailData;
  num totalAmount = 0;
  String stripeURL = "";
  String stripePaymentKey = "";

  init({required String stripePaymentPublishKey, required BookingDetailResponse data, required num totalAmount, required String stripeURL, required String stripePaymentKey}) {
    Stripe.publishableKey = stripePaymentPublishKey;
    Stripe.instance.applySettings().catchError((e) {
      return e;
    });

    bookDetailData = data;
    this.totalAmount = totalAmount;
    this.stripeURL = stripeURL;
    this.stripePaymentKey = stripePaymentKey;
    setValue("StripeKeyPayment", stripePaymentKey);
  }

  //StripPayment
  void stripePay() async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $stripePaymentKey',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };

    var request = http.Request('POST', Uri.parse(stripeURL));

    request.bodyFields = {
      'amount': '${(totalAmount.toInt() * 100)}',
      'currency': '${appStore.currencyCode}',
    };
    log('Booking Detail Response : ${bookDetailData.toJson()}');

    log(request.bodyFields);
    request.headers.addAll(headers);

    appStore.setLoading(true);

    await request.send().then((value) {
      appStore.setLoading(false);
      http.Response.fromStream(value).then((response) async {
        if (response.statusCode == 200) {
          StripePayModel res = StripePayModel.fromJson(await handleResponse(response));
          await Stripe.instance
              .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: res.client_secret.validate(),
              style: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              applePay: true,
              googlePay: true,
              testEnv: true,
              merchantCountryCode: 'IN',
              merchantDisplayName: mAppName,
              customerId: '1',
              customerEphemeralKeySecret: res.client_secret.validate(),
              setupIntentClientSecret: res.client_secret.validate(),
            ),
          )
              .then((value) {
                //
          }).catchError((e) {
            log(e.toString());
          });

          await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(setupIntentClientSecret: res.client_secret!)).then((value) {

            savePay(paymentMethod: PAYMENT_METHOD_STRIPE, paymentStatus: 'paid', data: bookDetailData);

          }).catchError((e) {
            log("presentPaymentSheet ${e.toString()}");
          });
          // await Stripe.instance.presentPaymentSheet(parameters: PresentPaymentSheetParameters(clientSecret: res.client_secret!, confirmPayment: true)).then(
          //   (value) async {
          //     toast("Hurray");
          //     savePay(paymentMethod: PAYMENT_METHOD_STRIPE, paymentStatus: 'paid', data: data);
          //   },
          // ).catchError((e) {
          //   log("presentPaymentSheet ${e.toString()}");
          // });
        } else if (response.statusCode == 400) {
          toast("Testing Credential cannot pay more then 500 ");
        }
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }
}

StripeServices stripeServices = StripeServices();
