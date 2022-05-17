import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/selected_item_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterCategoryComponent extends StatefulWidget {
  List<Category> catList;

  FilterCategoryComponent({required this.catList});

  @override
  State<FilterCategoryComponent> createState() => _FilterCategoryComponentState();
}

class _FilterCategoryComponentState extends State<FilterCategoryComponent> {
  int? isSelected;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.catList.length,
      itemBuilder: (context, index) {
        Category data = widget.catList[index];
        return Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name.validate(), style: boldTextStyle()),
                  4.height,
                  Text('${data.services} ${language!.service}', style: secondaryTextStyle()),
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
    ).visible(widget.catList.isNotEmpty, defaultWidget: BackgroundComponent(size: 200));
  }
}
