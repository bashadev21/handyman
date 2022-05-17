import 'package:booking_system_flutter/model/service_addresses_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceAddressListWidget extends StatefulWidget {
  final List<ServiceAddressesModel>? serviceAddressesList;
  final Function(int)? onServiceTap;

  ServiceAddressListWidget({this.serviceAddressesList, this.onServiceTap});

  @override
  ServiceAddressListWidgetState createState() => ServiceAddressListWidgetState();
}

class ServiceAddressListWidgetState extends State<ServiceAddressListWidget> {
  int? selectedOption = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.serviceAddressesList.validate().map((e) {
        int index = widget.serviceAddressesList.validate().indexOf(e);
        return Container(
          margin: EdgeInsets.only(top: 8, right: 8),
          padding: EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(8),
            backgroundColor: context.cardColor,
            border: Border.all(
              width: 1,
              color: selectedOption == index ? primaryColor : textSecondaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(8),
                  border: Border.all(
                    color: selectedOption == index ? primaryColor.withOpacity(0.3) : context.cardColor,
                  ),
                  backgroundColor: selectedOption == index ? primaryColor.withOpacity(0.3) : context.cardColor,
                ),
                width: 16,
                height: 16,
                child: Icon(Icons.done, size: 12, color: selectedOption == index ? white : context.cardColor),
              ).visible(selectedOption == index),
              4.width,
              Text(e.address.validate(), style: secondaryTextStyle(size: 16)),
            ],
          ),
        ).onTap(
          () {
            setState(() {
              selectedOption = index;
              widget.onServiceTap?.call(e.id.validate());
            });
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        );
      }).toList(),
    ).visible(widget.serviceAddressesList.validate().isNotEmpty);
  }
}
