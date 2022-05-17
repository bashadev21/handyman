import 'package:booking_system_flutter/component/app_common_dialog.dart';
import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/screens/booking/widgets/confirm_booking_dialog.dart';
import 'package:booking_system_flutter/screens/booking/widgets/coupun_widget.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:booking_system_flutter/utils/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingServiceStep2 extends StatefulWidget {
  final ServiceDetailResponse data;

  BookingServiceStep2({required this.data});

  @override
  _BookingServiceStep2State createState() => _BookingServiceStep2State();
}

class _BookingServiceStep2State extends State<BookingServiceStep2> {
  int itemCount = 1;
  CouponData? appliedCouponData;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    getPrice();
  }

  Widget priceWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language!.priceDetail, style: boldTextStyle()),
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
                    PriceWidget(price: widget.data.service_detail!.price.validate(), size: 18, color: textSecondaryColorGlobal, isBoldText: false),
                  ],
                ),
                Divider(height: 26),
                Row(
                  children: [
                    Text(language!.lblSubTotal, style: boldTextStyle()).expand(),
                    16.width,
                    Text(
                      '${appStore.currencySymbol}${widget.data.service_detail!.price.validate().toStringAsFixed(decimalPoint)} * $itemCount  = ${appStore.currencySymbol}${(widget.data.service_detail!.price.validate() * itemCount).toStringAsFixed(decimalPoint)}',
                      style: secondaryTextStyle(size: 18),
                    ).flexible(),
                  ],
                ),
                if (widget.data.service_detail!.taxAmount.validate() != 0)
                  Column(
                    children: [
                      Divider(height: 26),
                      Row(
                        children: [
                          Text(language!.lblTax, style: boldTextStyle()).expand(),
                          16.width,
                          PriceWidget(price: widget.data.service_detail!.taxAmount!, size: 18, color: Colors.red, isBoldText: false),
                        ],
                      ),
                    ],
                  ),
                if (widget.data.service_detail!.discount.validate() != 0)
                  Column(
                    children: [
                      Divider(height: 26),
                      Row(
                        children: [
                          Text(language!.lblDiscount, style: boldTextStyle()),
                          Text(
                            " (${widget.data.service_detail!.discount.validate()}% off)",
                            style: boldTextStyle(color: Colors.green),
                          ).expand(),
                          16.width,
                          PriceWidget(
                            price: widget.data.service_detail!.discountPrice!,
                            size: 18,
                            color: Colors.green,
                            isBoldText: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                Divider(height: 26),
                Row(
                  children: [
                    if (widget.data.service_detail!.appliedCouponData != null) Text(language!.lblCoupon, style: boldTextStyle()) else Text(language!.lblCoupon, style: boldTextStyle()).expand(),
                    if (widget.data.service_detail!.appliedCouponData != null)
                      Text(
                        "(${widget.data.service_detail!.appliedCouponData!.code})",
                        style: boldTextStyle(color: primaryColor),
                      ).onTap(() {
                        showInDialog<CouponData>(
                          context,
                          backgroundColor: context.cardColor,
                          contentPadding: EdgeInsets.zero,
                          builder: (p0) {
                            return AppCommonDialog(
                              title: language!.lblAvailableCoupons,
                              child: CouponWidget(
                                couponData: widget.data.coupon_data.validate(),
                                appliedCouponData: widget.data.service_detail!.appliedCouponData ?? null,
                              ),
                            );
                          },
                        ).then((CouponData? value) {
                          if (value != null) {
                            appliedCouponData = value;
                            getPrice();
                          } else {
                            appliedCouponData = null;
                            widget.data.service_detail!.appliedCouponData = null;
                            widget.data.service_detail!.couponCode = "";
                            getPrice();
                          }
                        });
                      }).expand(),
                    Text(
                      widget.data.service_detail!.appliedCouponData != null ? "" : language!.applyCoupon,
                      style: boldTextStyle(color: primaryColor),
                    ).onTap(() {
                      showInDialog<CouponData>(
                        context,
                        backgroundColor: context.cardColor,
                        contentPadding: EdgeInsets.zero,
                        builder: (p0) {
                          return AppCommonDialog(
                            title: language!.lblAvailableCoupons,
                            child: CouponWidget(
                              couponData: widget.data.coupon_data.validate(),
                              appliedCouponData: widget.data.service_detail!.appliedCouponData ?? null,
                            ),
                          );
                        },
                      ).then((CouponData? value) {
                        if (value != null) {
                          appliedCouponData = value;
                          getPrice();
                        } else {
                          appliedCouponData = null;
                          widget.data.service_detail!.appliedCouponData = null;
                          widget.data.service_detail!.couponCode = "";
                          getPrice();
                        }
                      });
                    }),
                    if (widget.data.service_detail!.appliedCouponData != null) PriceWidget(price: widget.data.service_detail!.couponDiscountAmount.validate(), color: Colors.green, isBoldText: false),
                  ],
                ),
                Divider(height: 32),
                Row(
                  children: [
                    Text(language!.totalAmount, style: boldTextStyle(size: 18)).expand(),
                    PriceWidget(
                      price: calculateTotalAmount(
                        serviceDiscountPercent: widget.data.service_detail!.discount.validate(),
                        qty: itemCount,
                        detail: widget.data.service_detail,
                        servicePrice: widget.data.service_detail!.price!,
                        taxes: widget.data.taxes!,
                        couponData: appliedCouponData,
                      ),
                      size: 18,
                      color: primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getPrice() {
    calculateTotalAmount(
      serviceDiscountPercent: widget.data.service_detail!.discount.validate(),
      qty: itemCount,
      detail: widget.data.service_detail,
      servicePrice: widget.data.service_detail!.price!,
      taxes: widget.data.taxes!,
      couponData: appliedCouponData,
    );
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: boxDecorationDefault(color: context.cardColor),
              width: context.width(),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.service_detail!.name.validate(), style: boldTextStyle()),
                      16.height,
                      Container(
                        height: 40,
                        padding: EdgeInsets.all(8),
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: context.scaffoldBackgroundColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_drop_down_sharp, size: 24).onTap(
                              () {
                                if (itemCount != 1) itemCount--;
                                getPrice();
                              },
                            ),
                            16.width,
                            Text(itemCount.toString(), style: primaryTextStyle()),
                            16.width,
                            Icon(Icons.arrow_drop_up_sharp, size: 24).onTap(
                              () {
                                itemCount++;
                                getPrice();
                              },
                            ),
                          ],
                        ),
                      ).visible(widget.data.service_detail!.isFixedService)
                    ],
                  ).expand(),
                    cachedImage(
                      widget.data.service_detail!.attchments.validate().isNotEmpty ? widget.data.service_detail!.attchments!.first.validate() : '',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(defaultRadius)
                ],
              ),
            ),
            16.height,
            priceWidget(),
            36.height,
            Row(
              children: [
                AppButton(
                  onTap: () {
                    customStepperController.previousPage(duration: 200.milliseconds, curve: Curves.easeInOut);
                  },
                  text: language!.lblPrevious,
                  textColor: textPrimaryColorGlobal,
                ).expand(),
                16.width,
                AppButton(
                  color: context.primaryColor,
                  onTap: () {
                    showInDialog(
                      context,
                      builder: (p0) {
                        return ConfirmBookingDialog(data: widget.data);
                      },
                    );
                  },
                  text: language!.lblBook,
                  textColor: Colors.white,
                ).expand(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
