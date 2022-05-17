import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceFaqWidget extends StatelessWidget {
  const ServiceFaqWidget({Key? key, required this.serviceFaq}) : super(key: key);

  final ServiceFaq? serviceFaq;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(serviceFaq!.title.validate(), style: primaryTextStyle()),
      backgroundColor: context.cardColor,
      tilePadding: EdgeInsets.symmetric(horizontal: 8),
      children: [
        SettingItemWidget(title: serviceFaq!.description.validate(), titleTextStyle: secondaryTextStyle(), padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8)),
      ],
    );
  }
}
