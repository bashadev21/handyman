import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/component/category_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/customer_ratings_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/featured_service_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/service_list_component.dart';
import 'package:booking_system_flutter/screens/dashboard/component/slider_and_location_component.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardFragment extends StatefulWidget {
  @override
  _DashboardFragmentState createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  late RegExp newValue;
  int value = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    LiveStream().on(streamUpdateDashboard, (p0) {
      setState(() {});
    });
    afterBuildCreated(() {
      setStatusBarColor(Colors.transparent);
    });
  }

  void newSplit() {
    String temp = "class200";

    newValue = RegExp('r^\d');
    log(newValue.pattern);
    log(newValue.matchAsPrefix(temp));

    temp.splitMapJoin(newValue.pattern);
    value = temp.split("class").join('').toInt();

    log(value);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    newSplit();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return await 2.seconds.delay;
        },
        child: Observer(
          builder: (_) {
            return FutureBuilder<DashboardResponse>(
              future: userDashboard(isCurrentLocation: appStore.isCurrentLocation, lat: getDoubleAsync(LATITUDE), long: getDoubleAsync(LONGITUDE)),
              builder: (context, snap) {
                if (snap.hasData) {

                  Configuration data = snap.data!.configurations!.firstWhere((element) => element.type == "CURRENCY");
                  if (data.country!.currency_code.validate() != appStore.currencyCode) appStore.setCurrencyCode(data.country!.currency_code.validate());
                  if (data.country!.id.validate().toString() != appStore.countryId.toString()) appStore.setCurrencyCountryId(data.country!.id.validate().toString());
                  if (data.country!.symbol.validate() != appStore.currencySymbol) appStore.setCurrencySymbol(data.country!.symbol.validate());

                  if (snap.data!.paymentSettings != null) {
                    setValue(PAYMENT_LIST, PaymentSetting.encode(snap.data!.paymentSettings.validate()));
                  }

                  return Stack(
                    children: [
                      SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SliderLocationComponent(sliderList: snap.data!.slider.validate(), notification_read_count: snap.data!.notification_unread_count.validate()),
                            32.height,
                            if (snap.data!.category!.isNotEmpty) CategoryComponent(categoryList: snap.data!.category!, isViewAll: true),
                            24.height,
                            ServiceListComponent(serviceList: snap.data!.service.validate()),
                            if (snap.data!.featuredServices!.isNotEmpty) FeaturedServicesComponent(serviceList: snap.data!.featuredServices.validate()),
                            16.height,
                            CustomerRatingsComponent(reviewData: snap.data!.dashboardCustomerReview.validate()),
                          ],
                        ),
                      ),
                      if (snap.connectionState == ConnectionState.waiting) LoaderWidget()
                    ],
                  );
                }
                return snapWidgetHelper(snap, loadingWidget: LoaderWidget());
              },
            );
          },
        ),
      ),
    );
  }
}
