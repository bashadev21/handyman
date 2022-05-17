import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', elevation: 0.0, color: transparentColor, backWidget: BackWidget()),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), backgroundColor: primaryColor),
              child: Image.asset(appLogo, height: 100, width: 100).center(),
            ),
            16.height,
            Text(mAppName, style: boldTextStyle()),
            16.height,
            SnapHelperWidget<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              onSuccess: (data) => Text('V ${data.version}', style: primaryTextStyle()),
            ),
          ],
        ),
      ),
    );
  }
}
