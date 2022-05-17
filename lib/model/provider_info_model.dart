import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/service_detail_model.dart';

import 'service_model.dart';

class ProviderInfoResponse {
  ProviderData? data;
  List<Service>? service;
  List<RatingData>? handymanRatingReview;

  ProviderInfoResponse({this.data, this.service, this.handymanRatingReview});

  ProviderInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProviderData.fromJson(json['data']) : null;
    if (json['service'] != null) {
      service = [];
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
    if (json['handyman_rating_review'] != null) {
      handymanRatingReview = [];
      json['handyman_rating_review'].forEach((v) {
        handymanRatingReview!.add(new RatingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    if (this.handymanRatingReview != null) {
      data['handyman_rating_review'] = this.handymanRatingReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  int? providerId;
  int? status;
  String? description;
  String? userType;
  String? email;
  String? contactNumber;
  int? countryId;
  int? stateId;
  int? cityId;
  String? cityName;
  String? address;
  int? providertypeId;
  String? providertype;
  int? isFeatured;
  String? displayName;
  String? createdAt;
  String? updatedAt;
  String? profileImage;
  String? timeZone;
  String? uid;
  String? loginType;
  int? serviceAddressId;
  String? lastNotificationSeen;
  num? providersServiceRating;
  num? handymanRating;
  int? isVerifyProvider;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.providerId,
      this.status,
      this.description,
      this.userType,
      this.email,
      this.contactNumber,
      this.countryId,
      this.stateId,
      this.cityId,
      this.cityName,
      this.address,
      this.providertypeId,
      this.providertype,
      this.isFeatured,
      this.displayName,
      this.createdAt,
      this.updatedAt,
      this.profileImage,
      this.timeZone,
      this.uid,
      this.loginType,
      this.serviceAddressId,
      this.lastNotificationSeen,
      this.providersServiceRating,
      this.handymanRating,
      this.isVerifyProvider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    providerId = json['provider_id'];
    status = json['status'];
    description = json['description'];
    userType = json['user_type'];
    email = json['email'];
    contactNumber = json['contact_number'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    address = json['address'];
    providertypeId = json['providertype_id'];
    providertype = json['providertype'];
    isFeatured = json['is_featured'];
    displayName = json['display_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profile_image'];
    timeZone = json['time_zone'];
    uid = json['uid'];
    loginType = json['login_type'];
    serviceAddressId = json['service_address_id'];
    lastNotificationSeen = json['last_notification_seen'];
    providersServiceRating = json['providers_service_rating'];
    handymanRating = json['handyman_rating'];
    isVerifyProvider = json['is_verify_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['provider_id'] = this.providerId;
    data['status'] = this.status;
    data['description'] = this.description;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['address'] = this.address;
    data['providertype_id'] = this.providertypeId;
    data['providertype'] = this.providertype;
    data['is_featured'] = this.isFeatured;
    data['display_name'] = this.displayName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_image'] = this.profileImage;
    data['time_zone'] = this.timeZone;
    data['uid'] = this.uid;
    data['login_type'] = this.loginType;
    data['service_address_id'] = this.serviceAddressId;
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['providers_service_rating'] = this.providersServiceRating;
    data['handyman_rating'] = this.handymanRating;
    data['is_verify_provider'] = this.isVerifyProvider;
    return data;
  }
}

class HandymanRatingReview {
  int? id;
  int? customerId;
  num? rating;
  String? review;
  int? serviceId;
  int? bookingId;
  int? handymanId;
  String? handymanName;
  String? handymanProfileImage;
  String? customerName;
  String? customerProfileImage;
  String? createdAt;

  HandymanRatingReview({this.id, this.customerId, this.rating, this.review, this.serviceId, this.bookingId, this.handymanId, this.handymanName, this.handymanProfileImage, this.customerName, this.customerProfileImage, this.createdAt});

  HandymanRatingReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    rating = json['rating'];
    review = json['review'];
    serviceId = json['service_id'];
    bookingId = json['booking_id'];
    handymanId = json['handyman_id'];
    handymanName = json['handyman_name'];
    handymanProfileImage = json['handyman_profile_image'];
    customerName = json['customer_name'];
    customerProfileImage = json['customer_profile_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['service_id'] = this.serviceId;
    data['booking_id'] = this.bookingId;
    data['handyman_id'] = this.handymanId;
    data['handyman_name'] = this.handymanName;
    data['handyman_profile_image'] = this.handymanProfileImage;
    data['customer_name'] = this.customerName;
    data['customer_profile_image'] = this.customerProfileImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}
