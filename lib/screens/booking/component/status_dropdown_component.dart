import 'package:async/async.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_status_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StatusDropdownComponent extends StatefulWidget {
  final String? defaultValue;
  final Function(BookingStatusResponse value) onValueChanged;
  final bool isValidate;

  StatusDropdownComponent({this.defaultValue, required this.onValueChanged, required this.isValidate});

  @override
  _StatusDropdownComponentState createState() => _StatusDropdownComponentState();
}

class _StatusDropdownComponentState extends State<StatusDropdownComponent> {
  BookingStatusResponse? selectedData;
  String? defaultValue;

  AsyncMemoizer<List<BookingStatusResponse>> _asyncMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingStatusResponse>>(
      future: _asyncMemoizer.runOnce(() => bookingStatus()),
      builder: (context, snap) {
        if (snap.hasData) {
          if (!snap.data!.any((element) => element.id == 0)) {
            snap.data!.insert(0, BookingStatusResponse(label: 'All', id: 0, status: 0, value: "All"));
            selectedData = snap.data!.first;
          }
          return DropdownButtonFormField<BookingStatusResponse>(
            onChanged: (value) {
              widget.onValueChanged.call(value!);
            },
            value: selectedData,
            isExpanded: true,
            validator: widget.isValidate
                ? (c) {
                    if (c == null) return language!.lblRequiredValidation;
                    return null;
                  }
                : null,
            decoration: inputDecoration(context),
            dropdownColor: context.cardColor,
            alignment: Alignment.bottomCenter,
            items: List.generate(
              snap.data!.length,
              (index) {
                BookingStatusResponse data = snap.data![index];
                return DropdownMenuItem(
                  value: data,
                  child: Text('${data.label.validate()}', style: primaryTextStyle()),
                );
              },
            ),
          );
        }
        return snapWidgetHelper(snap, defaultErrorMessage: "");
      },
    );
  }
}
