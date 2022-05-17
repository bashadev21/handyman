import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/selected_item_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterProviderComponent extends StatefulWidget {
  List<ProviderData> providerList;

  FilterProviderComponent({required this.providerList});

  @override
  State<FilterProviderComponent> createState() => _FilterProviderComponentState();
}

class _FilterProviderComponentState extends State<FilterProviderComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.providerList.length,
      itemBuilder: (context, index) {
        ProviderData data = widget.providerList[index];
        return Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              circleImage(image: data.profileImage.validate(), size: 45),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.displayName.validate(), style: boldTextStyle()),
                  4.height,
                  Text('${language!.lblMemberSince} ${DateFormat(YEAR).format(DateTime.parse(data.createdAt.validate()))}', style: secondaryTextStyle(size: 12)),
                ],
              ).expand(),
              SelectedItemWidget(isSelected: data.isSelected),
            ],
          ),
        ).onTap(() {
          if (data.isSelected) {
            data.isSelected = false;
          } else {
            data.isSelected = true;
          }
          setState(() {});
        });
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 0);
      },
    ).visible(widget.providerList.isNotEmpty, defaultWidget: BackgroundComponent(size: 200));
  }
}
