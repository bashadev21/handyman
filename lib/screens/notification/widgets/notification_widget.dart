import 'package:booking_system_flutter/model/notification_model.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationData data;

  NotificationWidget({required this.data});

  static String getTime(String inputString, String time) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0] + ' ' + time;
    } else {
      return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: boxDecorationDefault(color: data.readAt != null ? context.cardColor : gray.withOpacity(0.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: boxDecorationDefault(color: context.cardColor),
            alignment: Alignment.bottomCenter,
            child: data.profileImage.validate().isNotEmpty ? circleImage(image: data.profileImage.validate(), size: 60) : circleImage(image: ic_notification_user, size: 60),
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.data!.type.validate().split('_').join(' ').capitalizeFirstLetter()}', style: boldTextStyle()).expand(),
                  Text(data.createdAt.validate(), style: secondaryTextStyle(size: 12)),
                ],
              ),
              4.height,
              Text(data.data!.message!, style: secondaryTextStyle(), maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
