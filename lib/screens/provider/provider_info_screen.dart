import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/provider_info_model.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/provider/widgets/provider_list_widget.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProviderInfoScreen extends StatefulWidget {
  final int? providerId;

  ProviderInfoScreen({this.providerId});

  @override
  ProviderInfoScreenState createState() => ProviderInfoScreenState();
}

class ProviderInfoScreenState extends State<ProviderInfoScreen> {
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
              Text(language!.hintEmailTxt, style: boldTextStyle(size: 16)),
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
                  SearchListScreen(isFromProvider: false).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
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
    return FutureBuilder<ProviderInfoResponse>(
      future: getProviderDetail(widget.providerId.validate()),
      builder: (context, snap) {
        return Scaffold(
          appBar: appBarWidget(
            snap.hasData ? snap.data!.data!.displayName.validate() : "",
            textColor: white,
            elevation: 1.5,
            color: context.primaryColor,
            backWidget: BackWidget(),
          ),
          body: snap.hasData
              ? Stack(
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
                              Text(language!.lblAbout, style: boldTextStyle(size: 18)),
                              16.height,
                              if (snap.data!.data!.description.validate().isNotEmpty) aboutWidget(desc: snap.data!.data!.description.validate()),
                              emailWidget(data: snap.data!.data!),
                              32.height,
                              servicesWidget(list: snap.data!.service!),
                            ],
                          ).paddingAll(16),
                        ],
                      ),
                    ),
                  ],
                )
              : LoaderWidget(),
        );
      },
    );
  }
}
