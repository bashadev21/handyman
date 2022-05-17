import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayServices {
  static late Razorpay razorPay;
  static late String razorKeys;
  static late BookingDetailResponse dataa;

  static init({required String razorKey, required BookingDetailResponse data}) {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, RazorPayServices.handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, RazorPayServices.handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, RazorPayServices.handleExternalWallet);
    razorKeys = razorKey;
    dataa = data;
  }

  static void handlePaymentSuccess(PaymentSuccessResponse response) async {

    savePay(data: dataa, paymentMethod: PAYMENT_METHOD_RAZOR, paymentStatus: "paid", txnId: response.paymentId);
  }

  static void handlePaymentError(PaymentFailureResponse response) {
    toast("Error: " + response.code.toString() + " - " + response.message!, print: true);
  }

  static void handleExternalWallet(ExternalWalletResponse response) {
    toast("external_wallet: " + response.walletName!);
  }

  static void razorPayCheckout(num mAmount) async {
    var options = {
      'key': razorKeys,
      'amount': (mAmount * 100),
      'name': 'Booking System',
      'theme.color': '#5f60b9',
      'description': 'Booking System',
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'prefill': {'contact': appStore.userContactNumber, 'email': appStore.userEmail},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

void savePay({String? paymentMethod, String? txnId, String? paymentStatus = SERVICE_PAYMENT_STATUS_PENDING, required BookingDetailResponse data, num? totalAmount}) async {
  Map request = {
    CommonKeys.bookingId: data.booking_detail!.id.validate(),
    CommonKeys.customerId: appStore.userId,
    CouponKeys.discount: data.booking_detail!.discount.validate(),
    BookingServiceKeys.totalAmount: totalAmount ??
        calculateTotalAmount(
          servicePrice: data.booking_detail!.price.validate(),
          qty: data.booking_detail!.quantity.validate(),
          serviceDiscountPercent: data.booking_detail!.discount,
          taxes: data.booking_detail!.taxes,
          couponData: data.couponData,
        ),
    CommonKeys.dateTime: DateFormat(bookingSaveFormat).format(DateTime.now()),
    "txn_id": txnId != '' ? txnId : "#${data.booking_detail!.id.validate()}",
    "payment_status": paymentStatus,
    "payment_type": paymentMethod
  };
  log(request);

  appStore.setLoading(true);

  savePayment(request).then((value) {
    appStore.setLoading(false);
    push(HomeScreen(redirectToBooking: true), isNewTask: true);
  });
}
