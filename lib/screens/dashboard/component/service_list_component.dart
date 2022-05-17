import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceListComponent extends StatelessWidget {
  final List<Service> serviceList;

  ServiceListComponent({required this.serviceList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
        color: appStore.isDarkMode ? context.cardColor : "#F0F0FA".toColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(language!.service, style: boldTextStyle(size: 20)).expand(),
              TextButton(
                onPressed: () {
                  SearchListScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Slide);
                },
                child: Text(language!.lblViewAll,
                    style: secondaryTextStyle(size: 14)),
              )
            ],
          ).paddingOnly(right: 16, left: 16, top: 16),
          if (serviceList.isNotEmpty)
            HorizontalList(
              itemCount: serviceList.length,
              spacing: 16,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (context, index) => ServiceComponent(
                  serviceData: serviceList[index],
                  width: 280,
                  isBorderEnabled: true),
            )
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  Image.asset(notDataFoundImg, height: 126),
                  32.height,
                  Text(language!.lblNoServicesFound, style: boldTextStyle()),
                ],
              ),
            ).center(),
        ],
      ),
    );
  }
}
