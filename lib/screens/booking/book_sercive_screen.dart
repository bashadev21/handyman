import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/screens/booking/component/booking_service_step1.dart';
import 'package:booking_system_flutter/screens/booking/component/booking_service_step2.dart';
import 'package:booking_system_flutter/utils/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomStep {
  final String title;
  final Widget page;

  CustomStep({required this.title, required this.page});
}

class BookServiceScreen extends StatefulWidget {
  final ServiceDetailResponse data;
  final int bookingAddressId;

  BookServiceScreen({required this.data, this.bookingAddressId = 0});

  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  List<CustomStep>? stepsList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    stepsList = [
      CustomStep(title: language!.lblStep1, page: BookingServiceStep1(data: widget.data)),
      CustomStep(title: language!.lblStep2, page: BookingServiceStep2(data: widget.data)),
    ];
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.bookTheService, textColor: Colors.white, color: context.primaryColor, backWidget: BackWidget()),
      body: Container(
        child: Column(
          children: [
            CustomStepper(stepsList: stepsList.validate()).expand(),
          ],
        ),
      ),
    );
  }
}
