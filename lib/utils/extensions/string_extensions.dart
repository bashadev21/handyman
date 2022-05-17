import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension strEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color: color ?? (appStore.isDarkMode ? Colors.white : appTextSecondaryColor),
      errorBuilder: (context, error, stackTrace) => placeHolderWidget(height: size ?? 24, width: size ?? 24, fit: fit ?? BoxFit.cover),
    );
  }

  Color get getPaymentStatusBackgroundColor {
    switch (this) {
      case "Pending":
        return pendingColor;
      case "Accept":
        return acceptColor;
      case "On Going":
        return onGoingColor;
      case "In Progress":
        return inProgressColor;
      case "Hold":
        return holdColor;
      case "Cancelled":
        return cancelledColor;
      case "Rejected":
        return rejectedColor;
      case "Failed":
        return failedColor;
      case "Completed":
        return completedColor;

      default:
        return Color(0xFF3CAE5C);
    }
  }

  Color get getBookingActivityStatusColor {
    switch (this) {
      case "add_booking":
        return Color(0xFFEA2F2F);
      case "assigned_booking":
        return Color(0xFFFD6922);
      case "transfer_booking Going":
        return Color(0xFF00968A);
      case "update_booking_status Progress":
        return Color(0xFFFD6922);
      case "cancel_booking":
        return Color(0xFFC41520);
      case "payment_message_status":
        return Color(0xFFFFBD49);

      default:
        return Color(0xFF3CAE5C);
    }
  }
}
