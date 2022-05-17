import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCommonWidget extends StatelessWidget {
  const PriceCommonWidget({
    Key? key,
    required this.bookingDetail,
    required this.serviceDetail,
    required this.taxes,
    required this.couponData,
  }) : super(key: key);

  final BookingDetail bookingDetail;
  final ServiceDetail serviceDetail;
  final List<Taxe> taxes;
  final CouponData? couponData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language!.priceDetail, style: boldTextStyle(size: 18)),
          16.height,
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(color: context.cardColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(language!.lblPrice, style: boldTextStyle()).expand(),
                    16.width,
                    PriceWidget(price: serviceDetail.price.validate(), size: 18, color: textSecondaryColorGlobal, isBoldText: false),
                  ],
                ),
                if (bookingDetail.isHourlyService)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language!.lblSubTotal, style: boldTextStyle()),
                          Text(
                            '${appStore.currencySymbol}${serviceDetail.price.validate().toStringAsFixed(decimalPoint)} * ${bookingDetail.quantity}  = ${appStore.currencySymbol}${(serviceDetail.price.validate() * bookingDetail.quantity.validate()).toStringAsFixed(decimalPoint)}',
                            style: secondaryTextStyle(size: 18),
                            textAlign: TextAlign.right,
                          ).flexible(flex: 2),
                        ],
                      ),
                    ],
                  ),
                if (serviceDetail.taxAmount.validate() != 0)
                  Column(
                    children: [
                      Divider(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language!.lblTax, style: boldTextStyle()),
                          16.width,
                          PriceWidget(price: serviceDetail.taxAmount!, size: 18, color: Colors.red, isBoldText: false),
                        ],
                      ),
                    ],
                  ),
                if (serviceDetail.discountPrice.validate() != 0)
                  Row(
                    children: [
                      Column(
                        children: [
                          Divider(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  Text(language!.lblDiscount, style: boldTextStyle()),
                                  Text(" (${serviceDetail.discount.validate()}% off)", style: boldTextStyle(color: Colors.green)),
                                ],
                              ),
                              16.width,
                              PriceWidget(price: serviceDetail.discountPrice.validate(), size: 18, color: Colors.green, isBoldText: false, isDiscountedPrice: true),
                            ],
                          ),
                        ],
                      ).flexible(),
                    ],
                  ),
                if (couponData != null) Divider(height: 26),
                if (couponData != null)
                  Row(
                    children: [
                      Text(language!.lblCoupon, style: boldTextStyle()),
                      Text(" (${couponData!.code})", style: boldTextStyle(color: primaryColor)).expand(),
                      PriceWidget(price: serviceDetail.couponDiscountAmount.validate(), size: 18, color: Colors.green, isBoldText: false, isDiscountedPrice: true),
                    ],
                  ),
                Divider(height: 26),
                Row(
                  children: [
                    Text(language!.totalAmount, style: boldTextStyle(size: 18)).expand(),
                    if (bookingDetail.isHourlyService) Text('(${appStore.currencySymbol}${bookingDetail.price}/hr)  ', style: secondaryTextStyle()),
                    PriceWidget(price: getTotalValue, color: primaryColor, size: 18),
                  ],
                ),
                if (bookingDetail.isHourlyService && bookingDetail.status == BookingStatusKeys.complete)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        6.height,
                        Text(
                          "${language!.lblOnBase} ${calculateTimer(bookingDetail.durationDiff.validate().toInt())} ${getMinHour(durationDiff: bookingDetail.durationDiff.validate())}",
                          style: secondaryTextStyle(),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  num get getTotalValue {
    if (bookingDetail.isHourlyService && bookingDetail.status == BookingStatusKeys.complete) {
      return hourlyCalculation(
        price: calculateTotalAmount(
          serviceDiscountPercent: serviceDetail.discount.validate(),
          qty: bookingDetail.quantity!.toInt(),
          detail: serviceDetail,
          servicePrice: serviceDetail.price!,
          taxes: taxes,
          couponData: couponData,
        ),
        secTime: bookingDetail.durationDiff.validate().toInt(),
      );
    }
    return calculateTotalAmount(
      serviceDiscountPercent: serviceDetail.discount.validate(),
      qty: bookingDetail.quantity.validate().toInt(),
      detail: serviceDetail,
      servicePrice: serviceDetail.price!,
      taxes: taxes,
      couponData: couponData,
    );
  }

  String getMinHour({required String durationDiff}) {
    String totalTime = calculateTimer(durationDiff.toInt());
    List<String> totalHours = totalTime.split(":");
    if (totalHours.first == "00") {
      return "min";
    } else {
      return "hour";
    }
  }
}
