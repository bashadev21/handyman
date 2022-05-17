import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LocationServiceDialog extends StatefulWidget {
  final Function()? onAccept;

  LocationServiceDialog({this.onAccept});

  @override
  State<LocationServiceDialog> createState() => _LocationServiceDialogState();
}

class _LocationServiceDialogState extends State<LocationServiceDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appStore.isCurrentLocation ? language!.msgForLocationOn : language!.lblLocationOff, style: primaryTextStyle()).paddingAll(16),
          16.height,
          AppButton(
            text: language!.lblOk,
            width: context.width(),
            color: primaryColor,
            textColor: Colors.white,
            onTap: () async {
              getUserLocation().then((value) async {
                await appStore.setCurrentLocation(!appStore.isCurrentLocation);
                setState(() {});

                appStore.setLoading(true);

                finish(context, true);
              }).catchError((e) {
                log(e.toString());
              });
            },
          ).paddingAll(16)
        ],
      ),
    );
    return AlertDialog(
      backgroundColor: context.cardColor,
      elevation: 0,
      content: Text(appStore.isCurrentLocation ? language!.msgForLocationOn : language!.msgForLocationOff, style: primaryTextStyle()),
      actions: [
        MaterialButton(
          child: Text(language!.lblOk, style: primaryTextStyle()),
          onPressed: () async {
            //
          },
        ),
      ],
    );
  }
}
