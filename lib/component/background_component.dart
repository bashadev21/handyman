import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BackgroundComponent extends StatelessWidget {
  final String? image;
  final String? text;
  final double? size;

  BackgroundComponent({this.image, this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(),
      width: context.width(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 56,
            top: -304,
            child: Container(
              height: context.height() * 0.90,
              width: context.width() * 1.9,
              decoration: boxDecorationDefault(
                shape: BoxShape.circle,
                boxShadow: defaultBoxShadow(blurRadius: 0, spreadRadius: 0),
                color: context.cardColor,
              ),
            ),
          ),
          Positioned(
            top: 180,
            width: context.width(),
            height: context.height(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image ?? notDataFoundImg, width: size ?? 350),
                30.height,
                Text(text ?? language!.lblNoData, style: boldTextStyle(size: 24), textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
