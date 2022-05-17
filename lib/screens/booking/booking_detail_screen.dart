import 'package:booking_system_flutter/component/app_common_dialog.dart';
import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/model/user_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/booking/booking_history_component.dart';
import 'package:booking_system_flutter/screens/booking/component/price_common_widget.dart';
import 'package:booking_system_flutter/screens/booking/widgets/booking_detail_handyman_widget.dart';
import 'package:booking_system_flutter/screens/booking/widgets/booking_detail_provider_widget.dart';
import 'package:booking_system_flutter/screens/booking/widgets/reason_dialog.dart';
import 'package:booking_system_flutter/screens/handyman/handyman_info_screen.dart';
import 'package:booking_system_flutter/screens/payment/payment_screen.dart';
import 'package:booking_system_flutter/screens/provider/provider_info_screen.dart';
import 'package:booking_system_flutter/screens/review/component/add_review_widget.dart';
import 'package:booking_system_flutter/screens/review/rating_view_all_screen.dart';
import 'package:booking_system_flutter/screens/service/component/review_widget.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingDetailScreen extends StatefulWidget {
  final int bookingId;

  BookingDetailScreen({required this.bookingId});

  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Widget bookingIdWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language!.lblBookingID,
          style: boldTextStyle(size: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
        ),
        Text('#' + widget.bookingId.validate().toString(), style: boldTextStyle(color: primaryColor, size: 18)),
      ],
    );
  }

  Widget serviceDetailWidget({required BookingDetail bookingDetail, required ServiceDetail serviceDetail}) {
    return GestureDetector(
      onTap: () {
        ServiceDetailScreen(serviceId: bookingDetail.serviceId.validate()).launch(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bookingDetail.serviceName.validate(), style: boldTextStyle(size: 20)),
              16.height,
              Row(
                children: [
                  Text("${language!.lblDate} : ", style: boldTextStyle()),
                  bookingDetail.date.validate().isNotEmpty
                      ? Text(
                          formatDate(bookingDetail.date.validate(), format: DATE_FORMAT_2),
                          style: secondaryTextStyle(),
                        )
                      : SizedBox(),
                ],
              ).visible(bookingDetail.date.validate().isNotEmpty),
              8.height,
              Row(
                children: [
                  Text("${language!.lblTime} : ", style: boldTextStyle()),
                  bookingDetail.date.validate().isNotEmpty
                      ? Text(
                          formatDate(bookingDetail.date.validate(), format: Hour12Format),
                          style: secondaryTextStyle(),
                        )
                      : SizedBox(),
                ],
              ).visible(bookingDetail.date.validate().isNotEmpty),
              16.height,
            ],
          ).expand(),
          if (serviceDetail.attchments!.isNotEmpty)
            cachedImage(
              serviceDetail.attchments!.first,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(8)
        ],
      ),
    );
  }

  Widget handymanWidget({required List<UserData> handymanList, required ServiceDetail serviceDetail, required BookingDetail bookingDetail}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language!.lblAboutHandyman, style: boldTextStyle(size: 18)),
          16.height,
          Column(
            children: handymanList.map((e) {
              return BookingDetailHandymanWidget(
                handymanData: e,
                serviceDetail: serviceDetail,
                bookingDetail: bookingDetail,
                onUpdate: () {
                  setState(() {});
                },
              ).onTap(() {
                HandymanInfoScreen(handymanId: e.id).launch(context).then((value) => null);
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget providerWidget({required UserData providerData, required ServiceDetail serviceDetail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(language!.lblAboutProvider, style: boldTextStyle(size: 18)),
        16.height,
        BookingDetailProviderWidget(providerData: providerData).onTap(() {
          ProviderInfoScreen(providerId: providerData.id).launch(context);
        }),
      ],
    );
  }

  Widget customerReviewWidget({required List<RatingData> ratingList, required RatingData? customerReview, required BookingDetail bookingDetail}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bookingDetail.status == BookingStatusKeys.complete && bookingDetail.paymentStatus == "paid")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                if (customerReview == null)
                  Text(language!.lblRatedYet, style: boldTextStyle(size: 18))
                else
                  Row(
                    children: [
                      Text(language!.yourReview, style: boldTextStyle(size: 18)).expand(),
                      ic_edit_square.iconImage(size: 16).paddingAll(8).onTap(() {
                        showInDialog(
                          context,
                          contentPadding: EdgeInsets.zero,
                          builder: (p0) {
                            return AddReviewWidget(customerReview: customerReview);
                          },
                        ).then((value) {
                          if (value ?? false) {
                            setState(() {});
                          }
                        }).catchError((e) {
                          toast(e.toString());
                        });
                      }),
                      ic_delete.iconImage(size: 16).paddingAll(8).onTap(() {
                        deleteDialog(context, onSuccess: () async {
                          appStore.setLoading(true);

                          await deleteReview(id: customerReview.id.validate()).then((value) {
                            toast(value.message);
                          }).catchError((e) {
                            toast(e.toString());
                          });

                          setState(() {});

                          appStore.setLoading(false);
                        }, title: language!.lblDeleteReview, subTitle: language!.lblConfirmReviewSubTitle);
                        return;
                      }),
                    ],
                  ),
                16.height,
                if (customerReview == null)
                  AppButton(
                    color: context.primaryColor,
                    onTap: () {
                      showInDialog(
                        context,
                        contentPadding: EdgeInsets.zero,
                        builder: (p0) {
                          return AddReviewWidget(serviceId: bookingDetail.serviceId.validate(), bookingId: bookingDetail.id.validate());
                        },
                      ).then((value) {
                        if (value) {
                          setState(() {});
                        }
                      }).catchError((e) {
                        log(e.toString());
                      });
                    },
                    text: language!.btnRate,
                    textColor: Colors.white,
                  ).withWidth(context.width())
                else
                  ReviewWidget(data: customerReview)
              ],
            ),
          16.height,
          if (ratingList.isNotEmpty)
            Row(
              children: [
                Text(language!.review, style: boldTextStyle(size: 18)).expand(),
                Text(language!.lblViewAll, style: secondaryTextStyle()).onTap(() {
                  RatingViewAllScreen(ratingData: ratingList).launch(context);
                })
              ],
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ratingList.length,
            itemBuilder: (context, index) => ReviewWidget(data: ratingList[index]),
          ),
        ],
      ),
    );
  }

  void _handleCancelClick({required BookingDetailResponse status}) {
    if (status.booking_detail!.status == BookingStatusKeys.pending || status.booking_detail!.status == BookingStatusKeys.accept || status.booking_detail!.status == BookingStatusKeys.hold) {
      showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        builder: (context) {
          return AppCommonDialog(
            title: language!.lblCancelReason,
            child: ReasonDialog(status: status),
          );
          return ReasonDialog(status: status);
        },
      ).then((value) {
        if (value != null) {
          setState(() {});
        } else {
          log("He;");
        }
      });
    }
  }

  //region Hold Click
  void _handleHoldClick({required BookingDetailResponse status}) {
    if (status.booking_detail!.status == BookingStatusKeys.inProgress) {
      showInDialog(
        context,
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.scaffoldBackgroundColor,
        builder: (context) {
          return AppCommonDialog(
            title: language!.lblConfirmService,
            child: ReasonDialog(status: status, currentStatus: BookingStatusKeys.hold),
          );
          return ReasonDialog(status: status, currentStatus: BookingStatusKeys.hold);
        },
      ).then((value) {
        if (value != null) {
          setState(() {});
        } else {
          log("He;");
        }
      });
    }
  }

  //endregion

  //region Resume Service
  void _handleResumeClick({required BookingDetailResponse status}) {
    showConfirmDialogCustom(
      context,
      dialogType: DialogType.CONFIRMATION,
      primaryColor: context.primaryColor,
      negativeText: language!.lblNo,
      title: language!.lblConFirmResumeService,
      onAccept: (c) {
        resumeClick(status: status);
      },
    );
  }

  void resumeClick({required BookingDetailResponse status}) async {
    Map request = {
      CommonKeys.id: status.booking_detail!.id.validate(),
      BookingUpdateKeys.startAt: formatDate(DateTime.now().toString(), format: bookingSaveFormat),
      BookingUpdateKeys.endAt: status.booking_detail!.endAt.validate(),
      BookingUpdateKeys.durationDiff: status.booking_detail!.durationDiff.validate(),
      BookingUpdateKeys.reason: "",
      CommonKeys.status: BookingStatusKeys.inProgress,
    };

    log("Test $request");
    appStore.setLoading(true);

    await updateBooking(request).then((res) async {
      toast(res.message!);

      setState(() {});
    }).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  //endregion

  //region Start Service
  void startClick({required BookingDetailResponse status}) async {
    Map request = {
      CommonKeys.id: status.booking_detail!.id.validate(),
      BookingUpdateKeys.startAt: formatDate(DateTime.now().toString(), format: bookingSaveFormat),
      BookingUpdateKeys.endAt: status.booking_detail!.endAt.validate(),
      BookingUpdateKeys.durationDiff: 0,
      BookingUpdateKeys.reason: "",
      CommonKeys.status: BookingStatusKeys.inProgress,
    };

    log("Test $request");
    appStore.setLoading(true);

    await updateBooking(request).then((res) async {
      toast(res.message!);
      setState(() {});
    }).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  void _handleStartClick({required BookingDetailResponse status}) {
    showConfirmDialogCustom(
      context,
      dialogType: DialogType.CONFIRMATION,
      primaryColor: context.primaryColor,
      negativeText: language!.lblNo,
      onAccept: (c) {
        startClick(status: status);
      },
    );
  }

  //endregion

  //region Done Service
  void doneClick({required BookingDetailResponse status}) async {
    String endDateTime = DateFormat(bookingSaveFormat).format(DateTime.now());

    num durationDiff = DateTime.parse(endDateTime.validate()).difference(DateTime.parse(status.booking_detail!.startAt.validate())).inSeconds;

    Map request = {
      CommonKeys.id: status.booking_detail!.id.validate(),
      BookingUpdateKeys.startAt: status.booking_detail!.startAt.validate(),
      BookingUpdateKeys.endAt: endDateTime,
      BookingUpdateKeys.durationDiff: durationDiff,
      BookingUpdateKeys.reason: "Done",
      CommonKeys.status: BookingStatusKeys.complete,
    };

    log("Test $request");
    appStore.setLoading(true);

    await updateBooking(request).then((res) async {
      toast(res.message!);
      setState(() {});
    }).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  void _handleDoneClick({required BookingDetailResponse status}) {
    showConfirmDialogCustom(
      context,
      negativeText: language!.lblNo,
      dialogType: DialogType.CONFIRMATION,
      primaryColor: context.primaryColor,
      title: language!.lblEndServicesMsg,
      onAccept: (c) {
        doneClick(status: status);
      },
    );
  }

  //endregion

  Widget _action({required BookingDetailResponse status}) {
    if (status.booking_detail!.status == BookingStatusKeys.pending || status.booking_detail!.status == BookingStatusKeys.accept) {
      return AppButton(
        text: language!.lblCancelBooking,
        textColor: Colors.white,
        color: primaryColor,
        onTap: () {
          _handleCancelClick(status: status);
        },
      );
    } else if (status.booking_detail!.status == BookingStatusKeys.onGoing) {
      return AppButton(
        text: language!.lblStart,
        textColor: Colors.white,
        color: Colors.green,
        onTap: () {
          _handleStartClick(status: status);
        },
      );
    } else if (status.booking_detail!.status == BookingStatusKeys.inProgress) {
      return Row(
        children: [
          AppButton(
            text: language!.lblHold,
            textColor: Colors.white,
            color: holdColor,
            onTap: () {
              _handleHoldClick(status: status);
            },
          ).expand(),
          16.width,
          AppButton(
            text: language!.done,
            textColor: Colors.white,
            color: primaryColor,
            onTap: () {
              _handleDoneClick(status: status);
            },
          ).expand(),
        ],
      );
    } else if (status.booking_detail!.status == BookingStatusKeys.hold) {
      return Row(
        children: [
          AppButton(
            text: language!.lblResume,
            textColor: Colors.white,
            color: primaryColor,
            onTap: () {
              _handleResumeClick(status: status);
            },
          ).expand(),
          16.width,
          AppButton(
            text: language!.lblCancel,
            textColor: Colors.white,
            color: cancelledColor,
            onTap: () {
              _handleCancelClick(status: status);
            },
          ).expand(),
        ],
      );
    } else if (status.booking_detail!.status == BookingStatusKeys.complete && (status.booking_detail!.paymentStatus == "pending" || status.booking_detail!.paymentStatus == null)) {
      return AppButton(
        text: language!.lblPayNow,
        textColor: Colors.white,
        color: Colors.green,
        onTap: () {
          PaymentScreen(data: status).launch(context);
        },
      );
    }

    return SizedBox();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBodyWidget(AsyncSnapshot<BookingDetailResponse> snap) {
      if (snap.hasError) {
        return Text(snap.error.toString()).center();
      } else if (snap.hasData) {
        return Stack(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      bookingIdWidget(),
                      20.height,
                      Divider(height: 0),
                      16.height,
                      serviceDetailWidget(bookingDetail: snap.data!.booking_detail!, serviceDetail: snap.data!.service!),
                      16.height,
                      if (snap.data!.handyman_data!.isNotEmpty) handymanWidget(handymanList: snap.data!.handyman_data!, serviceDetail: snap.data!.service!, bookingDetail: snap.data!.booking_detail!),
                      28.height,
                      if (snap.data!.provider_data != null) providerWidget(providerData: snap.data!.provider_data!, serviceDetail: snap.data!.service!),
                      28.height,
                      PriceCommonWidget(
                          bookingDetail: snap.data!.booking_detail!, serviceDetail: snap.data!.service!, taxes: snap.data!.booking_detail!.taxes.validate(), couponData: snap.data!.couponData),
                      16.height,
                      customerReviewWidget(ratingList: snap.data!.rating_data.validate(), customerReview: snap.data!.customer_review, bookingDetail: snap.data!.booking_detail!),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: _action(status: snap.data!),
                )
              ],
            ),
            Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading),
            )
          ],
        );
      }
      return LoaderWidget().center();
    }

    return FutureBuilder<BookingDetailResponse>(
      future: getBookingDetail({
        CommonKeys.bookingId: widget.bookingId.toString(),
        CommonKeys.customerId: appStore.userId,
      }),
      builder: (context, snap) {
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
            return await 2.seconds.delay;
          },
          child: Scaffold(
            appBar: appBarWidget(
              snap.hasData ? snap.data!.booking_detail!.statusLabel.validate() : "",
              color: context.primaryColor,
              textColor: Colors.white,
              showBack: true,
              backWidget: BackWidget(),
              actions: [
                if (snap.hasData)
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
                        builder: (_) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.50,
                            minChildSize: 0.2,
                            maxChildSize: 1,
                            builder: (context, scrollController) => BookingHistoryComponent(data: snap.data!.booking_activity!.reversed.toList(), scrollController: scrollController),
                          );
                        },
                      );
                    },
                    child: Text(language!.lblCheckStatus, style: primaryTextStyle(color: Colors.white)),
                  ).paddingRight(16)
              ],
            ),
            body: buildBodyWidget(snap),
          ),
        );
      },
    );
  }
}
