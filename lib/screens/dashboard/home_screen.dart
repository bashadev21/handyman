import 'dart:ui';

import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/auth/sign_in_screen.dart';
import 'package:booking_system_flutter/screens/booking/booking_detail_screen.dart';
import 'package:booking_system_flutter/screens/booking/booking_list_screen.dart';
import 'package:booking_system_flutter/screens/category/category_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/chat_fragment.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/dash_fragment.dart';
import 'package:booking_system_flutter/screens/dashboard/fragment/profile_fragment.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomeScreen extends StatefulWidget {
  final bool? redirectToBooking;

  HomeScreen({this.redirectToBooking});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.redirectToBooking.validate(value: false)) {
      currentIndex = 1;
      setState(() {});
    }

    afterBuildCreated(() {
      // Handle Notification click and redirect to that Service & BookDetail screen
      if (isMobile) {
        OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult notification) async {
          if (notification.notification.additionalData!.containsKey('ID')) {
            String? notId = notification.notification.additionalData!["ID"];
            if (notId.validate().isNotEmpty) {
              BookingDetailScreen(bookingId: notId.toString().toInt()).launch(context);
            }
          } else if (notification.notification.additionalData!.containsKey('service_id')) {
            String? notId = notification.notification.additionalData!["service_id"];
            if (notId.validate().isNotEmpty) {
              ServiceDetailScreen(serviceId: notId.toInt()).launch(context);
            }
          }
        });
      }

      // Changes System theme when changed
      if (getIntAsync(THEME_MODE_INDEX) == ThemeModeSystem) {
        appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
      }
      window.onPlatformBrightnessChanged = () async {
        if (getIntAsync(THEME_MODE_INDEX) == ThemeModeSystem) {
          appStore.setDarkMode(context.platformBrightness() == Brightness.light);
        }
      };
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          toast(language!.lblBackPressMsg);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: [
          DashboardFragment(),
          Observer(
            builder: (context) {
              return appStore.isLoggedIn ? BookingListScreen() : SignInScreen(isFromDashboard: true);
            },
          ),
          CategoryScreen(hideAppBar: true),
          Observer(
            builder: (context) {
              return appStore.isLoggedIn ? ChatFragment() : SignInScreen(isFromDashboard: true);
            },
          ),
          ProfileFragment(),
        ][currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: ic_home.iconImage(color: appTextSecondaryColor),
              label: language!.dashboard,
              activeIcon: ic_fill_home.iconImage(color: primaryColor),
            ),
            BottomNavigationBarItem(
              icon: ic_ticket.iconImage(color: appTextSecondaryColor),
              label: language!.booking,
              activeIcon: ic_fill_ticket.iconImage(color: primaryColor),
            ),
            BottomNavigationBarItem(
              icon: ic_category.iconImage(color: appTextSecondaryColor),
              label: language!.category,
              activeIcon: ic_fill_category.iconImage(color: primaryColor),
            ),
            BottomNavigationBarItem(
              icon: ic_chat.iconImage(color: appTextSecondaryColor),
              label: language!.lblchat,
              activeIcon: ic_fill_chat.iconImage(color: primaryColor),
            ),
            BottomNavigationBarItem(
              icon: ic_profile2.iconImage(color: appTextSecondaryColor),
              label: language!.lblSetting,
              activeIcon: ic_fill_profile.iconImage(color: primaryColor),
            ),
          ],
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
