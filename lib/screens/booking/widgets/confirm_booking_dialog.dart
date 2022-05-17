import 'dart:convert';

import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class ConfirmBookingDialog extends StatefulWidget {
  final ServiceDetailResponse data;

  ConfirmBookingDialog({required this.data});

  @override
  State<ConfirmBookingDialog> createState() => _ConfirmBookingDialogState();
}

class _ConfirmBookingDialogState extends State<ConfirmBookingDialog> {
  Future<void> bookServices() async {
    Map request = {
      CommonKeys.id: "",
      CommonKeys.serviceId: widget.data.service_detail!.id.toString(),
      CommonKeys.providerId: widget.data.provider!.id.validate().toString(),
      CommonKeys.customerId: appStore.userId.toString().toString(),
      BookingServiceKeys.description: widget.data.provider!.description.validate().toString(),
      CommonKeys.address: widget.data.service_detail!.address.validate().toString(),
      CommonKeys.date: widget.data.service_detail!.dateTimeVal.validate().toString(),
      BookingServiceKeys.couponId: widget.data.service_detail!.couponCode.validate().toString(),
      BookService.amount: widget.data.service_detail!.price.toString(),
      BookService.quantity: '${widget.data.service_detail!.qty.validate()}',
      BookingServiceKeys.totalAmount: widget.data.service_detail!.totalAmount.toString(),
      CouponKeys.discount: widget.data.service_detail!.discount != null ? widget.data.service_detail!.discount.toString() : "",
      BookService.bookingAddressId: widget.data.service_detail!.bookingAddressId != -1 ? widget.data.service_detail!.bookingAddressId : null,
    };

    if (widget.data.taxes.validate().isNotEmpty) {
      request.putIfAbsent('tax', () => widget.data.taxes);
    }
    
    log("Booking Request  : - ${jsonEncode(request)}");
    appStore.setLoading(true);

    bookTheServices(request).then((value) {
      appStore.setLoading(false);

      HomeScreen(redirectToBooking: true).launch(context, isNewTask: true);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          width: context.width(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ic_confirm_check, height: 100, width: 100, color: primaryColor),

              24.height,
              Text(language!.lblConfirmBooking, style: boldTextStyle(size: 20)),
              16.height,
              Text(language!.lblConfirmMsg, style: primaryTextStyle(), textAlign: TextAlign.center),
              32.height,
              Row(
                children: [
                  AppButton(
                    onTap: () {
                      finish(context);
                    },
                    text: language!.lblCancel,
                    textColor: textPrimaryColorGlobal,
                  ).expand(),
                  16.width,
                  AppButton(
                    color: context.primaryColor,
                    onTap: () {
                      bookServices();
                    },
                    text: language!.confirm,
                    textColor: Colors.white,
                  ).expand(),
                ],
              )
              // Text('', style: boldTextStyle()),
            ],
          ).visible(
            !appStore.isLoading,
            defaultWidget: LoaderWidget().withSize(width: 250, height: 280),
          ),
        );
      },
    );
  }
}
