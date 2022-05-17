import 'package:booking_system_flutter/model/service_detail_model.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'pagination_model.dart';

class BookingListResponse {
  List<Booking>? data;
  Pagination? pagination;

  BookingListResponse({this.data, this.pagination});

  factory BookingListResponse.fromJson(Map<String, dynamic> json) {
    return BookingListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => Booking.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Booking {
  String? address;
  int? booking_address_id;
  CouponData? coupon_data;
  int? customer_id;
  String? customer_name;
  String? date;
  String? description;
  int? discount;
  String? duration_diff;
  String? duration_diff_hour;
  List<Handyman>? handyman;
  int? id;
  int? payment_id;
  String? payment_method;
  String? payment_status;
  int? price;
  int? provider_id;
  String? provider_name;
  int? quantity;
  List<String>? service_attchments;
  int? service_id;
  String? service_name;
  String? status;
  String? status_label;
  List<Taxe>? taxes;
  String? type;
  num? total_amount;

  //Local
  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;

  Booking({
    this.address,
    this.booking_address_id,
    this.coupon_data,
    this.customer_id,
    this.customer_name,
    this.date,
    this.description,
    this.discount,
    this.duration_diff,
    this.duration_diff_hour,
    this.handyman,
    this.id,
    this.payment_id,
    this.payment_method,
    this.payment_status,
    this.price,
    this.provider_id,
    this.provider_name,
    this.quantity,
    this.service_attchments,
    this.service_id,
    this.service_name,
    this.status,
    this.status_label,
    this.taxes,
    this.total_amount,
    this.type,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      address: json['address'],
      total_amount: json['total_amount'],
      booking_address_id: json['booking_address_id'],
      coupon_data: json['coupon_data'] != null ? CouponData.fromJson(json['coupon_data']) : null,
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      date: json['date'],
      description: json['description'],
      discount: json['discount'],
      duration_diff: json['duration_diff'],
      duration_diff_hour: json['duration_diff_hour'],
      handyman: json['handyman'] != null ? (json['handyman'] as List).map((i) => Handyman.fromJson(i)).toList() : null,
      id: json['id'],
      payment_id: json['payment_id'],
      payment_method: json['payment_method'],
      payment_status: json['payment_status'],
      price: json['price'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      quantity: json['quantity'],
      service_attchments: json['service_attchments'] != null ? new List<String>.from(json['service_attchments']) : null,
      service_id: json['service_id'],
      service_name: json['service_name'],
      status: json['status'],
      status_label: json['status_label'],
      taxes: json['taxes'] != null ? (json['taxes'] as List).map((i) => Taxe.fromJson(i)).toList() : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['booking_address_id'] = this.booking_address_id;
    data['customer_id'] = this.customer_id;
    data['customer_name'] = this.customer_name;
    data['total_amount'] = this.total_amount;
    data['date'] = this.date;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['duration_diff'] = this.duration_diff;
    data['duration_diff_hour'] = this.duration_diff_hour;
    data['id'] = this.id;
    data['payment_id'] = this.payment_id;
    data['payment_method'] = this.payment_method;
    data['payment_status'] = this.payment_status;
    data['price'] = this.price;
    data['provider_id'] = this.provider_id;
    data['provider_name'] = this.provider_name;
    data['quantity'] = this.quantity;
    data['service_id'] = this.service_id;
    data['service_name'] = this.service_name;
    data['status'] = this.status;
    data['status_label'] = this.status_label;
    data['type'] = this.type;
    if (this.coupon_data != null) {
      data['coupon_data'] = this.coupon_data!.toJson();
    }
    if (this.handyman != null) {
      data['handyman'] = this.handyman!.map((v) => v.toJson()).toList();
    }
    if (this.service_attchments != null) {
      data['service_attchments'] = this.service_attchments;
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Handyman {
  int? booking_id;
  String? created_at;
  String? deleted_at;
  HandymanX? handyman;
  int? handyman_id;
  int? id;
  String? updated_at;

  Handyman({this.booking_id, this.created_at, this.deleted_at, this.handyman, this.handyman_id, this.id, this.updated_at});

  factory Handyman.fromJson(Map<String, dynamic> json) {
    return Handyman(
      booking_id: json['booking_id'],
      created_at: json['created_at'],
      deleted_at: json['deleted_at'],
      handyman: json['handyman'] != null ? HandymanX.fromJson(json['handyman']) : null,
      handyman_id: json['handyman_id'],
      id: json['id'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.booking_id;
    data['created_at'] = this.created_at;
    data['deleted_at'] = this.deleted_at;
    data['handyman_id'] = this.handyman_id;
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    if (this.handyman != null) {
      data['handyman'] = this.handyman!.toJson();
    }
    return data;
  }
}

class HandymanX {
  String? address;
  int? city_id;
  String? contact_number;
  int? country_id;
  String? created_at;
  String? deleted_at;
  String? display_name;
  String? email;
  String? email_verified_at;
  String? first_name;
  int? id;
  int? is_featured;
  String? last_name;
  String? last_notification_seen;
  String? login_type;
  String? player_id;
  int? provider_id;
  String? providertype_id;
  int? service_address_id;
  int? state_id;
  int? status;
  String? time_zone;
  String? uid;
  String? updated_at;
  String? user_type;
  String? username;

  HandymanX(
      {this.address,
      this.city_id,
      this.contact_number,
      this.country_id,
      this.created_at,
      this.deleted_at,
      this.display_name,
      this.email,
      this.email_verified_at,
      this.first_name,
      this.id,
      this.is_featured,
      this.last_name,
      this.last_notification_seen,
      this.login_type,
      this.player_id,
      this.provider_id,
      this.providertype_id,
      this.service_address_id,
      this.state_id,
      this.status,
      this.time_zone,
      this.uid,
      this.updated_at,
      this.user_type,
      this.username});

  factory HandymanX.fromJson(Map<String, dynamic> json) {
    return HandymanX(
      address: json['address'],
      city_id: json['city_id'],
      contact_number: json['contact_number'],
      country_id: json['country_id'],
      created_at: json['created_at'],
      deleted_at: json['deleted_at'],
      display_name: json['display_name'],
      email: json['email'],
      email_verified_at: json['email_verified_at'],
      first_name: json['first_name'],
      id: json['id'],
      is_featured: json['is_featured'],
      last_name: json['last_name'],
      last_notification_seen: json['last_notification_seen'],
      login_type: json['login_type'],
      player_id: json['player_id'],
      provider_id: json['provider_id'],
      providertype_id: json['providertype_id'],
      service_address_id: json['service_address_id'],
      state_id: json['state_id'],
      status: json['status'],
      time_zone: json['time_zone'],
      uid: json['uid'],
      updated_at: json['updated_at'],
      user_type: json['user_type'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city_id'] = this.city_id;
    data['contact_number'] = this.contact_number;
    data['country_id'] = this.country_id;
    data['created_at'] = this.created_at;
    data['deleted_at'] = this.deleted_at;
    data['display_name'] = this.display_name;
    data['email'] = this.email;
    data['email_verified_at'] = this.email_verified_at;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['is_featured'] = this.is_featured;
    data['last_name'] = this.last_name;
    data['last_notification_seen'] = this.last_notification_seen;
    data['login_type'] = this.login_type;
    data['player_id'] = this.player_id;
    data['provider_id'] = this.provider_id;
    data['providertype_id'] = this.providertype_id;
    data['service_address_id'] = this.service_address_id;
    data['state_id'] = this.state_id;
    data['status'] = this.status;
    data['time_zone'] = this.time_zone;
    data['uid'] = this.uid;
    data['updated_at'] = this.updated_at;
    data['user_type'] = this.user_type;
    data['username'] = this.username;
    return data;
  }
}
