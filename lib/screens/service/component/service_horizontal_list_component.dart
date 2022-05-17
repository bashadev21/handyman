import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/screens/service/widgets/service_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceHorizontalListComponent extends StatefulWidget {
  final List<Service>? serviceList;

  ServiceHorizontalListComponent({this.serviceList});

  @override
  ServiceHorizontalListComponentState createState() => ServiceHorizontalListComponentState();
}

class ServiceHorizontalListComponentState extends State<ServiceHorizontalListComponent> {
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
    return HorizontalList(
      wrapAlignment: WrapAlignment.spaceEvenly,
      itemCount: widget.serviceList!.length,
      padding: EdgeInsets.all(16),
      spacing: 12,
      itemBuilder: (_, i) {
        Service data = widget.serviceList![i];
        return ServiceComponent(serviceData: data, width: context.width() * 0.8);
      },
    );
  }
}
