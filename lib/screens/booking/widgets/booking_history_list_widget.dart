import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/dashed_rect.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHistoryListWidget extends StatelessWidget {
  const BookingHistoryListWidget({Key? key, required this.data, required this.index, required this.length}) : super(key: key);

  final BookingActivity data;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data.datetime.validate().toString().isNotEmpty ? Text(formatDate(data.datetime..validate().toString(), format: Hour12Format), style: secondaryTextStyle(size: 12)) : SizedBox(),
            8.height,
            data.datetime.validate().toString().isNotEmpty ? Text(formatDate(data.datetime..validate().toString(), format: DATE_FORMAT_4), style: primaryTextStyle(size: 14)) : SizedBox(),
          ],
        ).withWidth(55),
        16.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: data.activity_type.validate().getBookingActivityStatusColor,
                borderRadius: radius(16),
              ),
            ),
            SizedBox(
              height: 65,
              child: DashedRect(
                gap: 3,
                color: data.activity_type.validate().getBookingActivityStatusColor,
                strokeWidth: 1.5,
              ),
            ).visible(index != length - 1),
          ],
        ),
        16.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextIcon(
              expandedText: true,
              edgeInsets: EdgeInsets.only(right: 4, left: 4, bottom: 4),
              text: data.activity_type.validate().replaceAll('_', ' ').capitalizeFirstLetter(),
            ),
            Text(
              data.activity_message.validate().replaceAll('_', ' ').capitalizeFirstLetter(),
              style: secondaryTextStyle(),
            ).paddingOnly(left: 4),
          ],
        ).paddingOnly(bottom: 18).expand()
      ],
    );
  }
}
