import 'package:booking_system_flutter/component/disabled_rating_bar_widget.dart';
import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/screens/provider/provider_info_screen.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceComponent extends StatefulWidget {
  final Service? serviceData;
  final double? width;
  final bool? isBorderEnabled;

  ServiceComponent({this.serviceData, this.width, this.isBorderEnabled});

  @override
  ServiceComponentState createState() => ServiceComponentState();
}

class ServiceComponentState extends State<ServiceComponent> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ServiceDetailScreen(serviceId: widget.serviceData!.id.validate())
            .launch(context);
      },
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(),
          backgroundColor: context.cardColor,
          border: widget.isBorderEnabled.validate(value: false)
              ? appStore.isDarkMode
                  ? Border.all(color: context.dividerColor)
                  : null
              : null,
        ),
        margin: EdgeInsets.only(bottom: 16),
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                cachedImage(
                  widget.serviceData!.attchments.validate().isNotEmpty
                      ? widget.serviceData!.attchments!.first.validate()
                      : '',
                  fit: BoxFit.cover,
                  height: 120,
                  width: context.width(),
                ).cornerRadiusWithClipRRectOnly(
                    topRight: defaultRadius.toInt(),
                    topLeft: defaultRadius.toInt()),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    constraints:
                        BoxConstraints(maxWidth: context.width() * 0.3),
                    decoration: boxDecorationWithShadow(
                      backgroundColor: context.cardColor.withOpacity(0.9),
                      borderRadius: radius(24),
                    ),
                    child: Marquee(
                      directionMarguee: DirectionMarguee.oneDirection,
                      child: Text(
                        "${widget.serviceData!.category_name.validate()}"
                            .toUpperCase(),
                        style: boldTextStyle(
                            color: appStore.isDarkMode ? white : primaryColor,
                            size: 12),
                      ).paddingSymmetric(horizontal: 8, vertical: 4),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -19,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: boxDecorationWithShadow(
                      backgroundColor: primaryColor,
                      borderRadius: radius(24),
                      border: Border.all(color: context.cardColor, width: 2),
                    ),
                    child: PriceWidget(
                        price: widget.serviceData!.price.validate(),
                        isHourlyService: widget.serviceData!.type.validate() ==
                            SERVICE_TYPE_HOURLY,
                        color: Colors.white,
                        hourlyTextColor: Colors.white),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.height,
                    DisabledRatingBarWidget(
                        rating: widget.serviceData!.total_rating.validate(),
                        size: 14),
                    16.height,
                    Marquee(
                      directionMarguee: DirectionMarguee.oneDirection,
                      child: Text(widget.serviceData!.name.validate(),
                          style: boldTextStyle(size: 16)),
                    ),
                    12.height,
                    Row(
                      children: [
                        circleImage(
                            image: widget.serviceData!.providerImage.validate(),
                            size: 30),
                        8.width,
                        if (widget.serviceData!.provider_name
                            .validate()
                            .isNotEmpty)
                          Text(
                            widget.serviceData!.provider_name.validate(),
                            style: secondaryTextStyle(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).expand()
                      ],
                    ).onTap(
                      () {
                        ProviderInfoScreen(
                                providerId:
                                    widget.serviceData!.provider_id.validate())
                            .launch(context);
                      },
                    ),
                  ],
                ).paddingAll(16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
