import 'package:booking_system_flutter/model/service_model.dart';
import 'package:booking_system_flutter/model/user_model.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceDetailResponse {
  List<CouponData>? coupon_data;
  UserData? provider;
  List<RatingData>? rating_data;
  ServiceDetail? service_detail;
  List<Taxe>? taxes;
  List<Service>? realted_service;
  List<ServiceFaq>? serviceFaq;

  ServiceDetailResponse({this.coupon_data, this.provider, this.rating_data, this.service_detail, this.taxes, this.realted_service, this.serviceFaq});

  factory ServiceDetailResponse.fromJson(Map<String, dynamic> json) {
    return ServiceDetailResponse(
      coupon_data: json['coupon_data'] != null ? (json['coupon_data'] as List).map((i) => CouponData.fromJson(i)).toList() : null,
      provider: json['provider'] != null ? UserData.fromJson(json['provider']) : null,
      rating_data: json['rating_data'] != null ? (json['rating_data'] as List).map((i) => RatingData.fromJson(i)).toList() : null,
      service_detail: json['service_detail'] != null ? ServiceDetail.fromJson(json['service_detail']) : null,
      taxes: json['taxes'] != null ? (json['taxes'] as List).map((i) => Taxe.fromJson(i)).toList() : null,
      realted_service: json['related_service'] != null ? (json['related_service'] as List).map((i) => Service.fromJson(i)).toList() : null,
      serviceFaq: json['service_faq'] != null ? (json['service_faq'] as List).map((i) => ServiceFaq.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupon_data != null) {
      data['coupon_data'] = this.coupon_data!.map((v) => v.toJson()).toList();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.rating_data != null) {
      data['rating_data'] = this.rating_data!.map((v) => v.toJson()).toList();
    }
    if (this.service_detail != null) {
      data['service_detail'] = this.service_detail!.toJson();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.realted_service != null) {
      data['related_service'] = this.realted_service!.map((v) => v.toJson()).toList();
    }
    if (this.serviceFaq != null) {
      data['service_faq'] = this.serviceFaq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Taxe {
  int? id;
  int? provider_id;
  String? title;
  String? type;
  int? value;
  num? totalCalculatedValue;

  Taxe({this.id, this.provider_id, this.title, this.type, this.value, this.totalCalculatedValue});

  factory Taxe.fromJson(Map<String, dynamic> json) {
    return Taxe(
      id: json['id'],
      provider_id: json['provider_id'],
      title: json['title'],
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.provider_id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class CouponData {
  String? code;
  num? discount;
  String? discount_type;
  String? expire_date;
  int? id;
  int? status;

  CouponData({this.code, this.discount, this.discount_type, this.expire_date, this.id, this.status});

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      code: json['code'],
      discount: json['discount'],
      discount_type: json['discount_type'],
      expire_date: json['expire_date'],
      id: json['id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_type'] = this.discount_type;
    data['expire_date'] = this.expire_date;
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}

class RatingData {
  int? booking_id;
  String? created_at;
  String? customer_name;
  int? id;
  String? profile_image;
  num? rating;
  int? customer_id;
  String? review;
  int? service_id;
  String? updated_at;

  int? handymanId;
  String? handymanName;
  String? handymanProfileImage;
  String? customerName;
  String? customerProfileImage;

  RatingData(
      {this.booking_id,
      this.created_at,
      this.customer_name,
      this.id,
      this.profile_image,
      this.rating,
      this.customer_id,
      this.review,
      this.service_id,
      this.updated_at,
      this.handymanId,
      this.handymanName,
      this.handymanProfileImage,
      this.customerName,
      this.customerProfileImage});

  factory RatingData.fromJson(Map<String, dynamic> json) {
    return RatingData(
      updated_at: json['updated_at'],
      booking_id: json['booking_id'],
      created_at: json['created_at'],
      customer_name: json['customer_name'],
      id: json['id'],
      profile_image: json['profile_image'],
      rating: json['rating'],
      customer_id: json['customer_id'],
      review: json['review'],
      service_id: json['service_id'],
      handymanId: json['handyman_id'],
      handymanName: json['handyman_name'],
      handymanProfileImage: json['handyman_profile_image'],
      customerName: json['customer_name'],
      customerProfileImage: json['customer_profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updated_at;
    data['booking_id'] = this.booking_id;
    data['created_at'] = this.created_at;
    data['customer_name'] = this.customer_name;
    data['id'] = this.id;
    data['profile_image'] = this.profile_image;
    data['customer_id'] = this.customer_id;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['service_id'] = this.service_id;

    data['handyman_id'] = this.handymanId;
    data['handyman_name'] = this.handymanName;
    data['handyman_profile_image'] = this.handymanProfileImage;
    data['customer_name'] = this.customerName;
    data['customer_profile_image'] = this.customerProfileImage;
    return data;
  }
}

class ServiceDetail {
  int? id;
  String? name;
  int? categoryId;
  int? providerId;
  num? price;
  String? priceFormat;
  String? type;
  num? discount;
  String? duration;
  int? status;
  String? description;
  int? isFeatured;
  String? providerName;
  String? categoryName;
  List<String>? attchments;
  num? totalReview;
  num? totalRating;
  int? isFavourite;
  List<ServiceAddressMapping>? serviceAddressMapping;

  //Set Values
  num? totalAmount;
  num? discountPrice;
  num? taxAmount;
  num? couponDiscountAmount;
  String? dateTimeVal;
  String? bookingDescription;
  String? couponCode;
  num? qty;
  String? address;
  int? bookingAddressId;
  CouponData? appliedCouponData;

  //Local
  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;
  bool get isFixedService => type.validate() == SERVICE_TYPE_FIXED;

  ServiceDetail({
    this.id,
    this.name,
    this.categoryId,
    this.providerId,
    this.price,
    this.priceFormat,
    this.type,
    this.discount,
    this.duration,
    this.status,
    this.description,
    this.isFeatured,
    this.providerName,
    this.categoryName,
    this.attchments,
    this.totalReview,
    this.totalRating,
    this.address,
    this.totalAmount,
    this.discountPrice,
    this.taxAmount,
    this.dateTimeVal,
    this.couponCode,
    this.qty,
    this.bookingAddressId,
    this.couponDiscountAmount,
    this.isFavourite,
    this.serviceAddressMapping,
  });

  ServiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    providerId = json['provider_id'];
    price = json['price'];
    priceFormat = json['price_format'];
    type = json['type'];
    discount = json['discount'];
    duration = json['duration'];
    status = json['status'];
    description = json['description'];
    isFeatured = json['is_featured'];
    providerName = json['provider_name'];
    categoryName = json['category_name'];
    attchments = json['attchments'].cast<String>();
    totalReview = json['total_review'];
    totalRating = json['total_rating'];
    isFavourite = json['is_favourite'];
    if (json['service_address_mapping'] != null) {
      serviceAddressMapping = [];
      json['service_address_mapping'].forEach((v) {
        serviceAddressMapping!.add(new ServiceAddressMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['provider_id'] = this.providerId;
    data['price'] = this.price;
    data['price_format'] = this.priceFormat;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['description'] = this.description;
    data['is_featured'] = this.isFeatured;
    data['provider_name'] = this.providerName;
    data['category_name'] = this.categoryName;
    data['attchments'] = this.attchments;
    data['total_review'] = this.totalReview;
    data['total_rating'] = this.totalRating;
    data['is_favourite'] = this.isFavourite;
    if (this.serviceAddressMapping != null) {
      data['service_address_mapping'] = this.serviceAddressMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceFaq {
  String? created_at;
  String? description;
  int? id;
  int? service_id;
  int? status;
  String? title;
  String? updated_at;

  ServiceFaq({this.created_at, this.description, this.id, this.service_id, this.status, this.title, this.updated_at});

  factory ServiceFaq.fromJson(Map<String, dynamic> json) {
    return ServiceFaq(
      created_at: json['created_at'],
      description: json['description'],
      id: json['id'],
      service_id: json['service_id'],
      status: json['status'],
      title: json['title'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['description'] = this.description;
    data['id'] = this.id;
    data['service_id'] = this.service_id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
