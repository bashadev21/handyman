import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/provider_info_model.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/provider/widgets/provider_list_widget.dart';
import 'package:booking_system_flutter/screens/review/rating_view_all_screen.dart';
import 'package:booking_system_flutter/screens/service/component/review_widget.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HandymanInfoScreen extends StatefulWidget {
  final int? handymanId;

  HandymanInfoScreen({this.handymanId});

  @override
  HandymanInfoScreenState createState() => HandymanInfoScreenState();
}

class HandymanInfoScreenState extends State<HandymanInfoScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget aboutWidget({required String desc}) {
    return Text(desc.validate(), style: boldTextStyle());
  }

  Widget emailWidget({required ProviderData data}) {
    return Container(
      decoration: boxDecorationDefault(color: context.cardColor),
      padding: EdgeInsets.all(16),
      width: context.width(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language!.txtemail, style: boldTextStyle(size: 16)),
              8.height,
              Text(data.email.validate(), style: secondaryTextStyle()),
              24.height,
            ],
          ).onTap(() {
            launchUrl("mailto: ${data.email.validate()}");
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language!.lblNumber, style: boldTextStyle(size: 16)),
              8.height,
              Text(data.contactNumber.validate(), style: secondaryTextStyle()),
              24.height,
            ],
          ).onTap(() {
            launchCall(data.contactNumber.validate());
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language!.lblMemberSince, style: boldTextStyle(size: 16)),
              8.height,
              Text("${DateTime.parse(data.createdAt.validate()).year}", style: secondaryTextStyle()),
            ],
          ).onTap(() {
            //
          }),
        ],
      ),
    );
  }

  Widget servicesWidget({required List<Service> list}) {
    return Column(
      children: [
        Row(
          children: [
            Text(language!.service, style: boldTextStyle(size: 20)).expand(),
            if (list.length > 5)
              TextButton(
                onPressed: () {
                  SearchListScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                child: Text(language!.lblViewAll, style: secondaryTextStyle(size: 12)),
              )
          ],
        ),
        16.height,
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(
            list.length,
            (index) {
              Service data = list[index];
              return ServiceComponent(serviceData: data, width: context.width());
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBodyWidget(AsyncSnapshot<ProviderInfoResponse> snap) {
      if (snap.hasError) {
        return Text(snap.error.toString()).center();
      } else if (snap.hasData) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProviderListWidget(data: snap.data!.data!, isOnTapEnabled: true),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Text(language!.about, style: boldTextStyle(size: 18)),
                      16.height,
                      if (snap.data!.data!.description.validate().isNotEmpty) aboutWidget(desc: snap.data!.data!.description.validate()),
                      emailWidget(data: snap.data!.data!),
                      Row(
                        children: [
                          Text(language!.review, style: boldTextStyle(size: 18)).expand(),
                          TextButton(
                            onPressed: () {
                              RatingViewAllScreen(ratingData: snap.data!.handymanRatingReview!).launch(context);
                            },
                            child: Text(language!.lblViewAll, style: secondaryTextStyle()),
                          )
                        ],
                      ),
                      snap.data!.handymanRatingReview.validate().isNotEmpty? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 6),
                        itemCount: snap.data!.handymanRatingReview.validate().length,
                        itemBuilder: (context, index) => ReviewWidget(data: snap.data!.handymanRatingReview.validate()[index], isCustomer: true),
                      ):Text(language!.lblNoReviews,style: secondaryTextStyle()).center().paddingOnly(top: 16),
                    ],
                  ).paddingAll(16),
                ],
              ),
            ),
          ],
        );
      }
      return LoaderWidget().center();
    }

    return FutureBuilder<ProviderInfoResponse>(
      future: getProviderDetail(widget.handymanId.validate()),
      builder: (context, snap) {
        return Scaffold(
          appBar: appBarWidget(
            snap.hasData ? snap.data!.data!.displayName.validate() : "",
            textColor: white,
            elevation: 1.5,
            color: context.primaryColor,
            backWidget: BackWidget(),
          ),
          body: buildBodyWidget(snap),
        );
      },
    );
  }
}
