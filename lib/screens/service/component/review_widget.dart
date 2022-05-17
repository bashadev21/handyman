import 'package:booking_system_flutter/component/disabled_rating_bar_widget.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ReviewWidget extends StatelessWidget {
  final RatingData data;
  final bool isCustomer;

  ReviewWidget({required this.data, this.isCustomer = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          circleImage(image: isCustomer ? data.customerProfileImage.validate() : data.profile_image.validate(), size: 70),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${data.customer_name.validate()}', style: boldTextStyle()).expand(),
                  8.width,
                  Text(formatDate(data.created_at.validate(), format: DATE_FORMAT_4), style: primaryTextStyle(size: 14)),
                  //TODO Change Time Ago Formate
                  /*   Text(
                    '${DateTime.parse(data.created_at.validate()).timeAgo}',
                    style: primaryTextStyle(size: 14),
                  ),*/
                ],
              ),
              8.height,
              DisabledRatingBarWidget(rating: data.rating.validate()),
              if (data.review.validate().isNotEmpty) Text('${data.review.validate()}', style: primaryTextStyle()).paddingTop(8),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
