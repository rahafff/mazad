import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

class OrderStatus {
  Map<String, Color> statusesColors = {
    "pending_payment": ColorManager.kPending,
    "pending": ColorManager.kPending,
    "accepted": ColorManager.kAccepted,
    "delivering": ColorManager.kDelivering,
    "delivered": ColorManager.kDelivered,
    "canceled": ColorManager.kCanceled
  };
  Map<String, String> statusesNames = {
    "pending_payment": AppStrings.pendingPayment,
    "pending": AppStrings.pending,
    "accepted": AppStrings.accepted,
    "delivering": AppStrings.delivering,
    "delivered": AppStrings.delivered,
    "canceled": AppStrings.canceled
  };
  final List<String> orderStatusesAsList = [
    "pending",
    "accepted",
    "delivering",
    "delivered",
  ];
  Map<String, bool> statusesState = {
    "pending": false,
    "accepted": false,
    "delivering": false,
    "delivered": false,
  };
}

class ProductStatus {
  Map<int, Color> statusesColors = {
   0: ColorManager.kRejected,
   2: ColorManager.kPendingProduct,
    1: ColorManager.kGreen,
  };
  Map<int, String> statusesNames = {
   2: AppStrings.pending,
   1: AppStrings.accepted,
    0: AppStrings.rejected,
  };
}

class ReviewStatus {
  Map<String, Color> reviewStatusesColors = {
    "pending": Colors.amber.shade700,
    "accepted": Colors.transparent,
    "rejected": Colors.red,
  };
  Map<String, String> reviewStatusesNames = {
    "pending": AppStrings.reviewIsPending,
    "accepted": "",
    "rejected": AppStrings.reviewIsRejected,
  };
}

class PaymentMethods {
  static const String cashOnDelivery = "cash_on_delivery";
  static const String online = "online";
}
