import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_list_model.dart';
import 'package:booking_system_flutter/model/booking_status_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/booking/booking_detail_screen.dart';
import 'package:booking_system_flutter/screens/booking/component/status_dropdown_component.dart';
import 'package:booking_system_flutter/screens/booking/widgets/booking_list_widget.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  ScrollController scrollController = ScrollController();

  int page = 1;
  List<Booking> mainList = [];

  String? selectedValue;
  String errorMessage = '';

  bool isEnabled = false;
  bool isApiCalled = false;
  bool isLastPage = false;
  bool fabIsVisible = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() {
      if (appStore.isLoggedIn) {
        setStatusBarColor(context.primaryColor);
      }
      return fetchAllBookingList(status: "All");
    });

    LiveStream().on(streamUpdateBookingList, (p0) {
      page = 1;
      fetchAllBookingList(status: selectedValue ?? "All");
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          loadMoreData(status: "All");
        }
      }
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          fabIsVisible = true;
        } else {
          fabIsVisible = false;
        }
      });
      setState(() {});
    });
  }

  Future fetchAllBookingList({required String status}) async {
    appStore.setLoading(true);
    errorMessage = '';
    await getBookingList(page, status: status).then((value) {
      if (page == 1) {
        mainList.clear();
      }
      mainList.addAll(value.data.validate());
      isApiCalled = true;
      selectedValue = status;
      isLastPage = value.data!.length != perPageItem;

      if (mainList.isEmpty) {
        errorMessage = language!.lblNoData;
      }
    }).catchError((e) {
      isApiCalled = true;
      errorMessage = e.toString();
    });
    setState(() {});

    appStore.setLoading(false);
  }

  Future loadMoreData({required String status}) async {
    appStore.setLoading(true);
    await getBookingList(page, status: selectedValue ?? "All").then((value) {
      appStore.setLoading(false);
      mainList.addAll(value.data.validate());

      isLastPage = false;
      setState(() {});
    }).catchError((e) {
      isLastPage = true;
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language!.booking,
        textColor: white,
        showBack: false,
        elevation: 3.0,
        color: context.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          fetchAllBookingList(status: selectedValue ?? "All");
          return await 2.seconds.delay;
        },
        child: Stack(
          children: [
            if (mainList.isNotEmpty)
              ListView.builder(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: mainList.length,
                itemBuilder: (_, index) {
                  Booking? data = mainList[index];

                  return GestureDetector(
                    onTap: () {
                      BookingDetailScreen(bookingId: data.id.validate()).launch(context);
                    },
                    child: BookingListWidget(data: data),
                  );
                },
              ).paddingOnly(left: 0, right: 0, bottom: 0, top: 76)
            else
              (mainList.validate().isEmpty && !appStore.isLoading && isApiCalled)
                  ? BackgroundComponent(
                      text: language!.lblNoBookingsFound,
                      size: context.height() * 0.35,
                    ).center()
                  : Offstage(),
            Positioned(
              left: 16,
              right: 16,
              top: 16,
              child: StatusDropdownComponent(
                isValidate: false,
                onValueChanged: (BookingStatusResponse value) {
                  page = 1;
                  fetchAllBookingList(status: value.value.toString());
                },
              ),
            ),
            Observer(
              builder: (context) => LoaderWidget().visible(appStore.isLoading),
            )
          ],
        ),
      ),
    );
  }
}
