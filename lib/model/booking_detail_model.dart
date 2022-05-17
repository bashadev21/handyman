import 'package:booking_system_flutter/model/user_model.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'service_detail_model.dart';

class BookingDetailResponse {
  List<BookingActivity>? booking_activity;
  BookingDetail? booking_detail;
  CouponData? couponData;
  CustomerData? customer;
  List<UserData>? handyman_data;
  UserData? provider_data;
  List<RatingData>? rating_data;
  ServiceDetail? service;
  RatingData? customer_review;
  List<Taxe>? taxes;

  BookingDetailResponse({
    this.booking_activity,
    this.booking_detail,
    this.couponData,
    this.customer,
    this.handyman_data,
    this.provider_data,
    this.service,
    this.rating_data,
    this.customer_review,
    this.taxes,
  });

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json) {
    return BookingDetailResponse(
      booking_activity: json['booking_activity'] != null ? (json['booking_activity'] as List).map((i) => BookingActivity.fromJson(i)).toList() : null,
      booking_detail: json['booking_detail'] != null ? BookingDetail.fromJson(json['booking_detail']) : null,
      couponData: json['coupon_data'] != null ? CouponData.fromJson(json['coupon_data']) : null,
      customer: json['customer'] != null ? CustomerData.fromJson(json['customer']) : null,
      handyman_data: json['handyman_data'] != null ? (json['handyman_data'] as List).map((i) => UserData.fromJson(i)).toList() : null,
      rating_data: json['rating_data'] != null ? (json['rating_data'] as List).map((i) => RatingData.fromJson(i)).toList() : null,
      provider_data: json['provider_data'] != null ? UserData.fromJson(json['provider_data']) : null,
      service: json['service'] != null ? ServiceDetail.fromJson(json['service']) : null,
      customer_review: json['customer_review'] != null ? RatingData.fromJson(json['customer_review']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.booking_activity != null) {
      data['booking_activity'] = this.booking_activity!.map((v) => v.toJson()).toList();
    }
    if (this.booking_detail != null) {
      data['booking_detail'] = this.booking_detail!.toJson();
    }
    if (this.couponData != null) {
      data['coupon_data'] = this.couponData!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.handyman_data != null) {
      data['handyman_data'] = this.handyman_data!.map((v) => v.toJson()).toList();
    }
    if (this.provider_data != null) {
      data['provider_data'] = this.provider_data!.toJson();
    }
    if (this.rating_data != null) {
      data['rating_data'] = this.rating_data!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.customer_review != null) {
      data['customer_review'] = this.customer_review!.toJson();
    }
    return data;
  }
}

class BookingActivity {
  String? activity_data;
  String? activity_message;
  String? activity_type;
  int? booking_id;
  String? created_at;
  String? datetime;
  String? deleted_at;
  int? id;
  String? updated_at;

  BookingActivity({this.activity_data, this.activity_message, this.activity_type, this.booking_id, this.created_at, this.datetime, this.deleted_at, this.id, this.updated_at});

  factory BookingActivity.fromJson(Map<String, dynamic> json) {
    return BookingActivity(
      activity_data: json['activity_data'],
      activity_message: json['activity_message'],
      activity_type: json['activity_type'],
      booking_id: json['booking_id'],
      created_at: json['created_at'],
      datetime: json['datetime'],
      deleted_at: json['deleted_at'],
      id: json['id'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_data'] = this.activity_data;
    data['activity_message'] = this.activity_message;
    data['activity_type'] = this.activity_type;
    data['booking_id'] = this.booking_id;
    data['created_at'] = this.created_at;
    data['datetime'] = this.datetime;
    data['deleted_at'] = this.deleted_at;
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class CustomerData {
  String? address;
  int? city_id;
  String? city_name;
  String? contact_number;
  int? country_id;
  String? created_at;
  String? description;
  String? display_name;
  String? email;
  String? first_name;
  int? id;
  int? is_featured;
  String? last_name;
  String? profile_image;
  String? provider_id;
  String? providertype;
  String? providertype_id;
  int? state_id;
  int? status;
  String? updated_at;
  String? user_type;
  String? username;

  CustomerData(
      {this.address,
      this.city_id,
      this.city_name,
      this.contact_number,
      this.country_id,
      this.created_at,
      this.description,
      this.display_name,
      this.email,
      this.first_name,
      this.id,
      this.is_featured,
      this.last_name,
      this.profile_image,
      this.provider_id,
      this.providertype,
      this.providertype_id,
      this.state_id,
      this.status,
      this.updated_at,
      this.user_type,
      this.username});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      address: json['address'],
      city_id: json['city_id'],
      city_name: json['city_name'],
      contact_number: json['contact_number'],
      country_id: json['country_id'],
      created_at: json['created_at'],
      description: json['description'],
      display_name: json['display_name'],
      email: json['email'],
      first_name: json['first_name'],
      id: json['id'],
      is_featured: json['is_featured'],
      last_name: json['last_name'],
      profile_image: json['profile_image'],
      provider_id: json['provider_id'],
      providertype: json['providertype'],
      providertype_id: json['providertype_id'],
      state_id: json['state_id'],
      status: json['status'],
      updated_at: json['updated_at'],
      user_type: json['user_type'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city_id'] = this.city_id;
    data['city_name'] = this.city_name;
    data['contact_number'] = this.contact_number;
    data['country_id'] = this.country_id;
    data['created_at'] = this.created_at;
    data['description'] = this.description;
    data['display_name'] = this.display_name;
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['is_featured'] = this.is_featured;
    data['last_name'] = this.last_name;
    data['profile_image'] = this.profile_image;
    data['provider_id'] = this.provider_id;
    data['providertype'] = this.providertype;
    data['providertype_id'] = this.providertype_id;
    data['state_id'] = this.state_id;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
    data['user_type'] = this.user_type;
    data['username'] = this.username;
    return data;
  }
}

class BookingDetail {
  int? id;
  String? address;
  int? customerId;
  int? serviceId;
  int? providerId;
  int? quantity;
  num? price;
  String? type;
  num? discount;
  String? status;
  String? statusLabel;
  String? description;
  String? reason;
  String? providerName;
  String? customerName;
  String? serviceName;
  String? paymentStatus;
  String? paymentMethod;
  int? totalReview;
  num? totalRating;
  String? date;
  String? startAt;
  String? endAt;
  String? durationDiff;
  int? paymentId;
  int? bookingAddressId;
  String? durationDiffHour;
  num? total_amount;
  List<Taxe>? taxes;

  //Local
  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;

  BookingDetail({
    this.id,
    this.address,
    this.customerId,
    this.serviceId,
    this.providerId,
    this.quantity,
    this.price,
    this.type,
    this.discount,
    this.status,
    this.statusLabel,
    this.description,
    this.reason,
    this.providerName,
    this.customerName,
    this.serviceName,
    this.paymentStatus,
    this.paymentMethod,
    this.totalReview,
    this.totalRating,
    this.date,
    this.startAt,
    this.endAt,
    this.durationDiff,
    this.paymentId,
    this.bookingAddressId,
    this.total_amount,
    this.taxes,
    this.durationDiffHour,
  });

  BookingDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    customerId = json['customer_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    quantity = json['quantity'];
    price = json['price'];
    type = json['type'];
    discount = json['discount'];
    status = json['status'];
    statusLabel = json['status_label'];
    description = json['description'];
    reason = json['reason'];
    providerName = json['provider_name'];
    customerName = json['customer_name'];
    serviceName = json['service_name'];
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    totalReview = json['total_review'];
    totalRating = json['total_rating'];
    date = json['date'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    durationDiff = json['duration_diff'];
    paymentId = json['payment_id'];
    total_amount = json['total_amount'];
    bookingAddressId = json['booking_address_id'];
    durationDiffHour = json['duration_diff_hour'];
    taxes = json['taxes'] != null ? (json['taxes'] as List).map((i) => Taxe.fromJson(i)).toList() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['customer_id'] = this.customerId;
    data['service_id'] = this.serviceId;
    data['provider_id'] = this.providerId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['status_label'] = this.statusLabel;
    data['description'] = this.description;
    data['reason'] = this.reason;
    data['total_amount'] = this.total_amount;
    data['provider_name'] = this.providerName;
    data['customer_name'] = this.customerName;
    data['service_name'] = this.serviceName;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    data['total_review'] = this.totalReview;
    data['total_rating'] = this.totalRating;
    data['date'] = this.date;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['duration_diff'] = this.durationDiff;
    data['payment_id'] = this.paymentId;
    data['booking_address_id'] = this.bookingAddressId;
    data['duration_diff_hour'] = this.durationDiffHour;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
