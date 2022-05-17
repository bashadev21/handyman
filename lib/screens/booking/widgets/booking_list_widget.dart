import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_list_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListWidget extends StatelessWidget {
  final Booking data;

  BookingListWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      width: context.width(),
      decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: radius()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              cachedImage(
                data.service_attchments!.isNotEmpty ? data.service_attchments!.first.validate() : '',
                fit: BoxFit.cover,
                width: context.width(),
                height: 150,
              ).cornerRadiusWithClipRRect(defaultRadius),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: boxDecorationWithShadow(
                    backgroundColor: data.status_label.validate().getPaymentStatusBackgroundColor,
                    borderRadius: radius(30),
                  ),
                  child: Text(
                    "${data.status_label.validate()}",
                    style: boldTextStyle(color: white, size: 12),
                  ).paddingSymmetric(horizontal: 8, vertical: 4),
                ),
              )
            ],
          ),
          16.height,

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${data.service_name.validate()}", style: boldTextStyle(size: 18), overflow: TextOverflow.ellipsis, maxLines: 2).expand(),
              8.width,
              Text('#' + data.id.validate().toString(), style: boldTextStyle(color: primaryColor, size: 20)),
            ],
          ),
          // 16.height,
          8.height,
          Row(
            children: [
              PriceWidget(
                price: data.isHourlyService
                    ? data.total_amount.validate()
                    : calculateTotalAmount(
                        servicePrice: data.price.validate(),
                        qty: data.quantity.validate(),
                        couponData: data.coupon_data != null ? data.coupon_data : null,
                        taxes: data.taxes.validate(),
                        serviceDiscountPercent: data.discount.validate(),
                      ).validate(),
                color: primaryColor,
                size: 20,
                isHourlyService: data.isHourlyService,
              ),
              4.width,
              if (data.discount.validate() != 0)
                Row(
                  children: [
                    Text('(${data.discount.validate()}%', style: boldTextStyle(size: 14, color: Colors.green)),
                    Text(' 0ff)', style: boldTextStyle(size: 14, color: Colors.green)),
                  ],
                ),
            ],
          ),

          16.height,
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(color: context.cardColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(language!.lblDate, style: boldTextStyle()),
                    Spacer(),
                    Text(formatDate(data.date.validate(), format: DATE_FORMAT_2), style: primaryTextStyle()),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(language!.lblTime, style: boldTextStyle()),
                    Spacer(),
                    Text(formatDate(data.date.validate(), format: Hour12Format), style: primaryTextStyle()),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(language!.textProvider, style: boldTextStyle()),
                    Spacer(),
                    Text(data.provider_name.validate(), style: primaryTextStyle()),
                  ],
                ),
                if (data.handyman!.validate().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Row(
                        children: [
                          Text(language!.textHandyman, style: boldTextStyle()),
                          Spacer(),
                          Text(data.handyman!.first.handyman!.display_name.validate(), style: primaryTextStyle()),
                        ],
                      ),
                    ],
                  ),
                Column(
                  children: [
                    Divider(),
                    Row(
                      children: [
                        Text(language!.payment, style: boldTextStyle()),
                        Spacer(),
                        Text(data.payment_status.validate() == SERVICE_PAYMENT_STATUS_PAID ? "Paid" : "Pending", style: primaryTextStyle(color: data.payment_status.validate() == SERVICE_PAYMENT_STATUS_PAID ? Colors.green : Colors.red)),
                      ],
                    ),
                  ],
                ),
                if (data.payment_status != null)
                  Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          Text(language!.paymentMethod, style: boldTextStyle()),
                          Spacer(),
                          Text(data.payment_method != null ? data.payment_method.validate().capitalizeFirstLetter() : "NA", style: primaryTextStyle()),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          8.height,
        ],
      ),
    );
  }
}
