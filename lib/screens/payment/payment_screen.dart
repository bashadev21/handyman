import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/screens/booking/component/price_common_widget.dart';
import 'package:booking_system_flutter/screens/payment/component/pay_stack.dart';
import 'package:booking_system_flutter/screens/payment/component/razor_pay_services.dart';
import 'package:booking_system_flutter/screens/payment/component/stripe_services.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/core/navigation_controller.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:flutterwave_standard/view/view_utils.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class PaymentScreen extends StatefulWidget {
  final BookingDetailResponse data;

  PaymentScreen({required this.data});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> implements TransactionCallBack {
  List<PaymentSetting> paymentList = [];

  PaymentSetting? currentTimeValue;

  late NavigationController controller;

  bool isDisabled = false;

  num totalAmount = 0;
  num price = 0;

  String flutterWavePublicKey = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    paymentList = PaymentSetting.decode(getStringAsync(PAYMENT_LIST));
    currentTimeValue = paymentList.first;
    if (widget.data.booking_detail!.isHourlyService) {
      num bookingTimeDiff = widget.data.booking_detail!.durationDiff.toInt();
      num servicePrice = widget.data.service!.totalAmount!.toInt();

      totalAmount = hourlyCalculation(secTime: bookingTimeDiff.toInt(), price: servicePrice);

      log(totalAmount);
    } else {
      totalAmount = calculateTotalAmount(
        serviceDiscountPercent: widget.data.service!.discount.validate(),
        qty: widget.data.booking_detail!.quantity!.toInt(),
        detail: widget.data.service,
        servicePrice: widget.data.service!.price!,
        taxes: widget.data.booking_detail!.taxes,
        couponData: widget.data.couponData,
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _handleClick() async {
    if (currentTimeValue!.type == PAYMENT_METHOD_COD) {
      savePay(data: widget.data, paymentMethod: PAYMENT_METHOD_COD, totalAmount: totalAmount);
    } else if (currentTimeValue!.type == PAYMENT_METHOD_STRIPE) {
      if (currentTimeValue!.is_test == 1) {
        stripeServices.init(
            stripePaymentPublishKey: currentTimeValue!.test_value!.stripe_publickey.validate(),
            data: widget.data,
            totalAmount: totalAmount,
            stripeURL: currentTimeValue!.test_value!.stripe_url.validate(),
            stripePaymentKey: currentTimeValue!.test_value!.stripe_key.validate());
        await 1.seconds.delay;
        stripeServices.stripePay();
      } else {
        stripeServices.init(
            stripePaymentPublishKey: currentTimeValue!.live_value!.stripe_publickey.validate(),
            data: widget.data,
            totalAmount: totalAmount,
            stripeURL: currentTimeValue!.live_value!.stripe_url.validate(),
            stripePaymentKey: currentTimeValue!.live_value!.stripe_key.validate());
        await 1.seconds.delay;
        stripeServices.stripePay();
      }
    } else if (currentTimeValue!.type == PAYMENT_METHOD_RAZOR) {
      if (currentTimeValue!.is_test == 1) {
        appStore.setLoading(true);
        RazorPayServices.init(razorKey: currentTimeValue!.test_value!.razor_key!, data: widget.data);
        await 1.seconds.delay;
        appStore.setLoading(false);
        RazorPayServices.razorPayCheckout(totalAmount);
      } else {
        appStore.setLoading(true);
        RazorPayServices.init(razorKey: currentTimeValue!.live_value!.razor_key!, data: widget.data);
        await 1.seconds.delay;
        appStore.setLoading(false);
        RazorPayServices.razorPayCheckout(totalAmount);
      }
    } else if (currentTimeValue!.type == PAYMENT_METHOD_FLUTTER_WAVE) {
      if (currentTimeValue!.is_test == 1) {
        appStore.setLoading(true);
        flutterWaveCheckout(flutterWavePublicKeys: currentTimeValue!.test_value!.flutterwave_public.validate());
      } else {
        appStore.setLoading(true);
        flutterWaveCheckout(flutterWavePublicKeys: currentTimeValue!.live_value!.flutterwave_public.validate());
      }
    } else if (currentTimeValue!.type == PAYMENT_METHOD_PAYSTACK) {
      if (currentTimeValue!.is_test == 1) {
        appStore.setLoading(true);
        payStackApi.init(payStackPublicKey: currentTimeValue!.test_value!.paystack_public.validate(), totalAmount: totalAmount);
        await 1.seconds.delay;
        appStore.setLoading(false);
        payStackApi.payStackPayment(context);
      } else {
        appStore.setLoading(true);
        payStackApi.init(payStackPublicKey: currentTimeValue!.live_value!.paystack_public.validate(), totalAmount: totalAmount);
        await 1.seconds.delay;
        appStore.setLoading(false);
        payStackApi.payStackPayment(context);
      }
    }
  }

  @override
  onTransactionError() {
    toast("transaction error");
    snackBar(context, title: errorMessage);
  }

  @override
  onCancelled() {
    toast("Transaction Cancelled");
  }

  void _toggleButtonActive(final bool shouldEnable) {
    setState(() {
      isDisabled = !shouldEnable;
    });
  }

  void flutterWaveCheckout({required String flutterWavePublicKeys}) {
    flutterWavePublicKey = flutterWavePublicKeys;
    if (isDisabled) return;
    _showConfirmDialog();
  }

  final style = FlutterwaveStyle(
      appBarText: "My Standard Blue",
      buttonColor: Color(0xffd0ebff),
      appBarIcon: Icon(Icons.message, color: Color(0xffd0ebff)),
      buttonTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      appBarColor: Color(0xffd0ebff),
      dialogCancelTextStyle: TextStyle(color: Colors.redAccent, fontSize: 18),
      dialogContinueTextStyle: TextStyle(color: Colors.blue, fontSize: 18));

  void _showConfirmDialog() {
    FlutterwaveViewUtils.showConfirmPaymentModal(
      context,
      getStringAsync(CURRENCY_COUNTRY_CODE),
      totalAmount.toString(),
      style.getMainTextStyle(),
      style.getDialogBackgroundColor(),
      style.getDialogCancelTextStyle(),
      style.getDialogContinueTextStyle(),
      _handlePayment,
    );
  }

  void _handlePayment() async {
    final Customer customer = Customer(
      name: widget.data.customer!.display_name.toString(),
      phoneNumber: widget.data.customer!.contact_number.toString(),
      email: widget.data.customer!.email.toString(),
    );

    final request = StandardRequest(
      txRef: DateTime.now().millisecond.toString(),
      amount: totalAmount.toString(),
      customer: customer,
      paymentOptions: "card, payattitude",
      customization: Customization(title: "Test Payment"),
      isTestMode: true,
      publicKey: flutterWavePublicKey,
      currency: getStringAsync(CURRENCY_COUNTRY_CODE),
      redirectUrl: "https://www.google.com",
    );

    try {
      Navigator.of(context).pop(); // to remove confirmation dialog
      _toggleButtonActive(false);
      controller.startTransaction(request);
      _toggleButtonActive(true);
    } catch (error) {
      _toggleButtonActive(true);

      toast(error.toString());
    }
  }

  @override
  onTransactionSuccess(String id, String txRef) {
    final ChargeResponse chargeResponse = ChargeResponse(status: "success", success: true, transactionId: id, txRef: txRef);
    savePay(paymentMethod: PAYMENT_METHOD_FLUTTER_WAVE, paymentStatus: SERVICE_PAYMENT_STATUS_PAID, data: widget.data, totalAmount: totalAmount, txnId: chargeResponse.transactionId);
  }

  @override
  Widget build(BuildContext context) {
    controller = NavigationController(Client(), style, this);

    return Scaffold(
      appBar: appBarWidget(language!.payment, color: context.primaryColor, textColor: Colors.white, backWidget: BackWidget()),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PriceCommonWidget(
                    bookingDetail: widget.data.booking_detail!,
                    serviceDetail: widget.data.service!,
                    taxes: widget.data.booking_detail!.taxes.validate(),
                    couponData: widget.data.couponData,
                  ),
                  32.height,
                  Text(language!.lblChoosePaymentMethod, style: boldTextStyle(size: 18)),
                ],
              ).paddingAll(16),
              if (paymentList.isNotEmpty)
                ListView.builder(
                  itemCount: paymentList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    PaymentSetting value = paymentList[index];
                    return RadioListTile<PaymentSetting>(
                      dense: true,
                      activeColor: primaryColor,
                      value: value,
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: currentTimeValue,
                      onChanged: (PaymentSetting? ind) {
                        currentTimeValue = ind;
                        setState(() {});
                      },
                      title: Text(value.title.validate(), style: primaryTextStyle()),
                    );
                  },
                )
              else
                Column(
                  children: [
                    24.height,
                    Image.asset(notDataFoundImg, height: 150),
                    16.height,
                    Text(language!.lblNoPayments, style: boldTextStyle()).center(),
                  ],
                ),
              Spacer(),
              if (paymentList.isNotEmpty)
                AppButton(
                  onTap: () {
                    if (currentTimeValue!.type == PAYMENT_METHOD_COD) {
                      showConfirmDialogCustom(
                        context,
                        dialogType: DialogType.CONFIRMATION,
                        title: "${language!.lblPayWith} ${currentTimeValue!.title.validate()}",
                        primaryColor: primaryColor,
                        onAccept: (p0) {
                          _handleClick();
                        },
                      );
                    } else {
                      _handleClick();
                    }
                  },
                  text: "${language!.payWith} ${currentTimeValue!.title.validate()}",
                  color: context.primaryColor,
                  width: context.width(),
                ).paddingAll(16),
            ],
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
