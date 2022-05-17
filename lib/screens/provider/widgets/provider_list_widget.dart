import 'package:booking_system_flutter/component/disabled_rating_bar_widget.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/screens/provider/provider_info_screen.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProviderListWidget extends StatelessWidget {
  final ProviderData data;
  final bool? isOnTapEnabled;

  ProviderListWidget({required this.data, this.isOnTapEnabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOnTapEnabled.validate(value: false)
          ? null
          : () {
              ProviderInfoScreen(providerId: data.id).launch(context);
            },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: boxDecorationDefault(color: context.cardColor, border: Border.all(color: context.dividerColor, width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            circleImage(image: data.profileImage.validate(),size: 90),

            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.displayName.validate(), style: boldTextStyle(size: 18)),
                    Icon(Icons.verified, size: 22, color: Colors.green).visible(data.isVerifyProvider == 1),
                  ],
                ),
                16.height,
                Text('${data.userType.capitalizeFirstLetter()}', style: primaryTextStyle()),
                8.height,
                DisabledRatingBarWidget(rating: data.providersServiceRating.validate()),
              ],
            ).expand(),
          ],
        ),
      ),
    );
  }
}
