import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FeaturedServicesComponent extends StatelessWidget {
  final List<Service> serviceList;

  FeaturedServicesComponent({required this.serviceList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Row(
            children: [
              Text(language!.lblFeatured, style: boldTextStyle(size: 20)).expand(),
              TextButton(
                onPressed: () {
                  SearchListScreen(isFeatured: "1").launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                child: Text(language!.lblViewAll, style: secondaryTextStyle(size: 14)),
              )
            ],
          ).paddingOnly(right: 16, left: 16, top: 16),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: List.generate(serviceList.length, (index) {
              Service data = serviceList[index];
              return ServiceComponent(serviceData: data, width: context.width() / 2 - 26);
            }),
          ).paddingSymmetric(horizontal: 16, vertical: 8)
        ],
      ),
    );
  }
}
