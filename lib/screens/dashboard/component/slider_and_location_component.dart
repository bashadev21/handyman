import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/screens/notification/notification_screen.dart';
import 'package:booking_system_flutter/screens/service/search_list_screen.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SliderLocationComponent extends StatefulWidget {
  final List<SliderModel> sliderList;
  final int? notification_read_count;

  SliderLocationComponent({required this.sliderList, this.notification_read_count});

  @override
  State<SliderLocationComponent> createState() => _SliderLocationComponentState();
}

class _SliderLocationComponentState extends State<SliderLocationComponent> {
  PageController sliderPageController = PageController(initialPage: 0);

  Widget getSliderWidget() {
    return SizedBox(
      height: 325,
      width: context.width(),
      child: widget.sliderList.isNotEmpty
          ? Stack(
              children: [
                PageView(
                  controller: sliderPageController,
                  children: List.generate(
                    widget.sliderList.length,
                    (index) {
                      SliderModel data = widget.sliderList[index];
                      return cachedImage(
                        data.slider_image,
                        height: 250,
                        width: context.width(),
                        fit: BoxFit.cover,
                      ).onTap(() {
                        if (data.type == 'service') {
                          ServiceDetailScreen(serviceId: data.type_id.validate().toInt()).launch(
                            context,
                            pageRouteAnimation: PageRouteAnimation.Slide,
                          );
                        }
                      });
                    },
                  ),
                ),
                if (widget.sliderList.length.validate() > 1)
                  Positioned(
                    bottom: 34,
                    left: 0,
                    right: 0,
                    child: DotIndicator(
                      pageController: sliderPageController,
                      pages: widget.sliderList,
                      indicatorColor: white,
                      unselectedIndicatorColor: white,
                      currentBoxShape: BoxShape.rectangle,
                      boxShape: BoxShape.rectangle,
                      borderRadius: radius(2),
                      currentBorderRadius: radius(3),
                      currentDotSize: 18,
                      currentDotWidth: 6,
                      dotSize: 6,
                    ),
                  ),
                if (appStore.isLoggedIn)
                  Positioned(
                    top: context.statusBarHeight + 16,
                    right: 16,
                    child: Container(
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.circle),
                      height: 36,
                      padding: EdgeInsets.all(8),
                      width: 36,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ic_notification.iconImage(size: 24, color: primaryColor).center(),
                          Positioned(
                            top: -20,
                            right: -10,
                            child: widget.notification_read_count.validate() > 0
                                ? Container(
                                    padding: EdgeInsets.all(6),
                                    child: FittedBox(
                                      child: Text(widget.notification_read_count.toString(), style: primaryTextStyle(color: Colors.white)),
                                    ),
                                    decoration: boxDecorationDefault(color: Colors.red, shape: BoxShape.circle),
                                  )
                                : Offstage(),
                          )
                        ],
                      ),
                    ).onTap(() {
                      NotificationScreen().launch(context);
                    }),
                  )
              ],
            )
          : cachedImage(''),
    );
  }

  Decoration get commonDecoration {
    return boxDecorationDefault(
      color: context.cardColor,
      boxShadow: [
        BoxShadow(color: shadowColorGlobal, offset: Offset(1, 0)),
        BoxShadow(color: shadowColorGlobal, offset: Offset(0, 1)),
        BoxShadow(color: shadowColorGlobal, offset: Offset(-1, 0)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        getSliderWidget(),
        Positioned(
          bottom: -24,
          right: 16,
          left: 16,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: commonDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ic_location.iconImage(color: appStore.isDarkMode ? Colors.white : Colors.black),
                    8.width,
                    Text(
                      appStore.isCurrentLocation ? getStringAsync(CURRENT_ADDRESS) : language!.lblLocationOff,
                      style: secondaryTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ).expand(),
                    8.width,
                    commonLocationWidget(
                      context: context,
                      color: appStore.isCurrentLocation ? primaryColor : grey,
                      onTap: () {
                        //
                      },
                    )
                  ],
                ),
              ).expand(),
              16.width,
              GestureDetector(
                onTap: () {
                  SearchListScreen(isSearchFocus: true).launch(context);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: commonDecoration,
                  child: ic_search.iconImage(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
