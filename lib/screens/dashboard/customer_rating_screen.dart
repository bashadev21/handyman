import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/background_component.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/screens/dashboard/component/customer_rating_widget.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerRatingScreen extends StatefulWidget {
  final List<DashboardCustomerReview> reviewData;

  CustomerRatingScreen({required this.reviewData});

  @override
  State<CustomerRatingScreen> createState() => _CustomerRatingScreenState();
}

class _CustomerRatingScreenState extends State<CustomerRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.lblReviewsOnServices, textColor: Colors.white, color: context.primaryColor, backWidget: BackWidget()),
      body: widget.reviewData.validate().isEmpty
          ? BackgroundComponent(text: language!.lblNoRateYet, image: no_rating_bar)
          : ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return CustomerRatingWidget(
                data: widget.reviewData[index],
                onDelete: (data) {
                  widget.reviewData.remove(data);
                  setState(() {});
                },
              );
            },
            itemCount: widget.reviewData.length,
          ),
    );
  }
}
