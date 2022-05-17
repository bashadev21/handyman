import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/notification_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/booking/booking_detail_screen.dart';
import 'package:booking_system_flutter/screens/notification/widgets/notification_widget.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> unReadNotificationList = [];
  List<NotificationData> readNotificationList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    getAllNotification();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void getAllNotification() async {
    appStore.setLoading(true);
    await getNotification({NotificationKey.type: ""}).then((value) {
      if (unReadNotificationList.isNotEmpty) {
        unReadNotificationList.clear();
      }
      if (readNotificationList.isNotEmpty) {
        readNotificationList.clear();
      }
      unReadNotificationList = value.notificationData!.where((element) => element.readAt == null).toList();
      readNotificationList = value.notificationData!.where((element) => element.readAt != null).toList();

      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });
    appStore.setLoading(false);
  }

  Future<void> readNotification({String? id}) async {
    Map request = {CommonKeys.bookingId: id};

    appStore.setLoading(true);

    await getBookingDetail(request).then((value) {}).catchError((e) {
      toast(e.toString(), print: true);
    });

    appStore.setLoading(false);
  }

  Widget listIterate(List<NotificationData> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        NotificationData data = list[index];

        return GestureDetector(
          onTap: () async {
            readNotification(id: data.data!.id.toString());
            await BookingDetailScreen(bookingId: data.data!.id.validate()).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
          },
          child: NotificationWidget(data: data),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.lnlNotification, color: context.primaryColor, textColor: Colors.white, backWidget: BackWidget()),
      body: RefreshIndicator(
        onRefresh: () async {
          getAllNotification();
          return await 2.seconds.delay;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
              child: Column(
                children: [
                  if (unReadNotificationList.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(language!.lblUnreadNotification, style: boldTextStyle()).expand(),
                            TextButton(
                              onPressed: () async {
                                appStore.setLoading(true);

                                await getNotification({NotificationKey.type: MarkAsRead}).then((value) {
                                  getAllNotification();
                                }).catchError((e) {
                                  log(e.toString());
                                });

                                appStore.setLoading(false);
                              },
                              child: Text(language!.markAsRead, style: primaryTextStyle(size: 12)),
                            )
                          ],
                        ),
                        listIterate(unReadNotificationList),
                      ],
                    ).paddingAll(8),
                  16.height,
                  if (readNotificationList.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(language!.lnlNotification, style: boldTextStyle()),
                          ],
                        ).paddingAll(8),
                        listIterate(readNotificationList),
                      ],
                    ),
                ],
              ),
            ),
            Observer(builder: (BuildContext context) => LoaderWidget().visible(appStore.isLoading))
          ],
        ),
      ),
    );
  }
}
