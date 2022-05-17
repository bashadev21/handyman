import 'dart:convert';

import 'service_model.dart';

class DashboardResponse {
  List<Category>? category;
  List<Configuration>? configurations;
  List<ProviderData>? provider;
  List<Service>? service;
  List<Service>? featuredServices;
  List<SliderModel>? slider;
  List<PaymentSetting>? paymentSettings;
  List<DashboardCustomerReview>? dashboardCustomerReview;
  bool? status;
  bool? is_paypal_configuration;
  int? notification_unread_count;
  String? privacy_policy;
  String? term_conditions;
  String? inquriy_email;
  String? helpline_number;


  DashboardResponse({
    this.category,
    this.configurations,
    this.is_paypal_configuration,
    this.featuredServices,
    this.provider,
    this.service,
    this.slider,
    this.status,
    this.paymentSettings,
    this.dashboardCustomerReview,
    this.notification_unread_count,
    this.privacy_policy,
    this.term_conditions,
    this.inquriy_email,
    this.helpline_number,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      category: json['category'] != null ? (json['category'] as List).map((i) => Category.fromJson(i)).toList() : null,
      configurations: json['configurations'] != null ? (json['configurations'] as List).map((i) => Configuration.fromJson(i)).toList() : null,
      is_paypal_configuration: json['is_paypal_configuration'],
      provider: json['provider'] != null ? (json['provider'] as List).map((i) => ProviderData.fromJson(i)).toList() : null,
      service: json['service'] != null ? (json['service'] as List).map((i) => Service.fromJson(i)).toList() : null,
      featuredServices: json['featured_service'] != null ? (json['featured_service'] as List).map((i) => Service.fromJson(i)).toList() : null,
      slider: json['slider'] != null ? (json['slider'] as List).map((i) => SliderModel.fromJson(i)).toList() : null,
      paymentSettings: json['payment_settings'] != null ? (json['payment_settings'] as List).map((i) => PaymentSetting.fromJson(i)).toList() : null,
      dashboardCustomerReview: json['customer_review'] != null ? (json['customer_review'] as List).map((i) => DashboardCustomerReview.fromJson(i)).toList() : null,
      status: json['status'],
      notification_unread_count: json['notification_unread_count'],
      privacy_policy: json['privacy_policy'],
      term_conditions: json['term_conditions'],
      inquriy_email: json['inquriy_email'],
      helpline_number: json['helpline_number'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_paypal_configuration'] = this.is_paypal_configuration;
    data['status'] = this.status;
    data['notification_unread_count'] = this.notification_unread_count;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.configurations != null) {
      data['configurations'] = this.configurations!.map((v) => v.toJson()).toList();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    if (this.featuredServices != null) {
      data['featured_service'] = this.service!.map((v) => v.toJson()).toList();
    }
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    if (this.paymentSettings != null) {
      data['payment_settings'] = this.paymentSettings!.map((v) => v.toJson()).toList();
    }
    if (this.dashboardCustomerReview != null) {
      data['customer_review'] = this.dashboardCustomerReview!.map((v) => v.toJson()).toList();
    }
    data['privacy_policy'] = this.privacy_policy;
    data['term_conditions'] = this.term_conditions;
    data['inquriy_email'] = this.inquriy_email;
    data['helpline_number'] = this.helpline_number;

    return data;
  }
}

class Category {
  String? category_image;
  String? color;
  String? description;
  int? id;
  int? is_featured;
  String? name;
  int? status;
  bool isSelected;
  int? services;

  Category({this.category_image, this.color, this.description, this.id, this.is_featured, this.name, this.status, this.isSelected = false, this.services});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category_image: json['category_image'],
      color: json['color'],
      description: json['description'],
      id: json['id'],
      is_featured: json['is_featured'],
      name: json['name'],
      status: json['status'],
      services: json['services'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_image'] = this.category_image;
    data['color'] = this.color;
    data['description'] = this.description;
    data['id'] = this.id;
    data['is_featured'] = this.is_featured;
    data['name'] = this.name;
    data['status'] = this.status;
    data['services'] = this.services;
    return data;
  }
}

class ProviderData {
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
  String? lastNotificationSeen;
  String? uid;
  String? loginType;
  int? serviceAddressId;
  num? providersServiceRating;
  num? handymanRating;
  int? isVerifyProvider;

  bool isSelected = false;

  ProviderData({this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.providerId,
    this.status,
    this.description,
    this.userType,
    this.email,
    this.contactNumber,
    this.isSelected = false,
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
    this.lastNotificationSeen,
    this.uid,
    this.loginType,
    this.serviceAddressId,
    this.providersServiceRating,
    this.handymanRating,
    this.isVerifyProvider});

  ProviderData.fromJson(Map<String, dynamic> json) {
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
    lastNotificationSeen = json['last_notification_seen'];
    uid = json['uid'];
    loginType = json['login_type'];
    //serviceAddressId = json['service_address_id'];
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
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['uid'] = this.uid;
    data['login_type'] = this.loginType;
    data['service_address_id'] = this.serviceAddressId;
    data['providers_service_rating'] = this.providersServiceRating;
    data['handyman_rating'] = this.handymanRating;
    data['is_verify_provider'] = this.isVerifyProvider;
    return data;
  }
}

class Configuration {
  Country? country;
  int? id;
  String? key;
  String? type;
  String? value;

  Configuration({this.country, this.id, this.key, this.type, this.value});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
      id: json['id'],
      key: json['key'],
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['type'] = this.type;
    data['value'] = this.value;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Country {
  String? code;
  String? currency_code;
  String? currency_name;
  var dial_code;
  int? id;
  String? name;
  String? symbol;

  Country({this.code, this.currency_code, this.currency_name, this.dial_code, this.id, this.name, this.symbol});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      currency_code: json['currency_code'],
      currency_name: json['currency_name'],
      dial_code: json['dial_code'],
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['currency_code'] = this.currency_code;
    data['currency_name'] = this.currency_name;
    data['dial_code'] = this.dial_code;
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}

class SliderModel {
  String? description;
  int? id;
  String? service_name;
  String? slider_image;
  int? status;
  String? title;
  String? type;
  String? type_id;

  SliderModel({this.description, this.id, this.service_name, this.slider_image, this.status, this.title, this.type, this.type_id});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      description: json['description'],
      id: json['id'],
      service_name: json['service_name'],
      slider_image: json['slider_image'],
      status: json['status'],
      title: json['title'],
      type: json['type'],
      type_id: json['type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['service_name'] = this.service_name;
    data['slider_image'] = this.slider_image;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['type_id'] = this.type_id;
    return data;
  }
}

class PaymentSetting {
  int? id;
  int? is_test;
  LiveValue? live_value;
  int? status;
  String? title;
  String? type;
  LiveValue? test_value;

  PaymentSetting({this.id, this.is_test, this.live_value, this.status, this.title, this.type, this.test_value});

  static String encode(List<PaymentSetting> paymentList) {
    return json.encode(paymentList.map<Map<String, dynamic>>((payment) => payment.toJson()).toList());
  }

  static List<PaymentSetting> decode(String musics) {
    return (json.decode(musics) as List<dynamic>).map<PaymentSetting>((item) => PaymentSetting.fromJson(item)).toList();
  }

  factory PaymentSetting.fromJson(Map<String, dynamic> json) {
    return PaymentSetting(
      id: json['id'],
      is_test: json['is_test'],
      live_value: json['live_value'] != null ? LiveValue.fromJson(json['live_value']) : null,
      status: json['status'],
      title: json['title'],
      type: json['type'],
      test_value: json['value'] != null ? LiveValue.fromJson(json['value']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_test'] = this.is_test;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    if (this.live_value != null) {
      data['live_value'] = this.live_value?.toJson();
    }
    if (this.test_value != null) {
      data['value'] = this.test_value?.toJson();
    }
    return data;
  }
}

class LiveValue {
  String? stripe_url;
  String? stripe_key;
  String? stripe_publickey;
  String? razor_url;
  String? razor_key;
  String? razor_secret;
  String? flutterwave_public;
  String? flutterwave_secret;
  String? flutterwave_encryption;
  String? paystack_public;

  LiveValue(
      {this.stripe_url, this.stripe_key, this.stripe_publickey, this.razor_url, this.razor_key, this.razor_secret, this.flutterwave_public, this.flutterwave_secret, this.flutterwave_encryption, this.paystack_public});

  factory LiveValue.fromJson(Map<String, dynamic> json) {
    return LiveValue(
      stripe_url: json['stripe_url'],
      stripe_key: json['stripe_key'],
      stripe_publickey: json['stripe_publickey'],
      razor_url: json['razor_url'],
      razor_key: json['razor_key'],
      razor_secret: json['razor_secret'],
      flutterwave_public: json['flutterwave_public'],
      flutterwave_secret: json['flutterwave_secret'],
      flutterwave_encryption: json['flutterwave_encryption'],
      paystack_public: json['paystack_public'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stripe_url'] = this.stripe_url;
    data['stripe_key'] = this.stripe_key;
    data['stripe_publickey'] = this.stripe_publickey;
    data['razor_url'] = this.razor_url;
    data['razor_key'] = this.razor_key;
    data['razor_secret'] = this.razor_secret;
    data['flutterwave_public'] = this.flutterwave_public;
    data['flutterwave_secret'] = this.flutterwave_secret;
    data['flutterwave_encryption'] = this.flutterwave_encryption;
    data['paystack_public'] = this.paystack_public;
    return data;
  }
}

class DashboardCustomerReview {
  List<String>? attchments;
  int? booking_id;
  String? created_at;
  int? customer_id;
  String? customer_name;
  int? id;
  String? profile_image;
  num? rating;
  String? review;
  int? service_id;
  String? service_name;

  DashboardCustomerReview(
      {this.attchments, this.booking_id, this.created_at, this.customer_id, this.customer_name, this.id, this.profile_image, this.rating, this.review, this.service_id, this.service_name});

  factory DashboardCustomerReview.fromJson(Map<String, dynamic> json) {
    return DashboardCustomerReview(
      attchments: json['attchments'] != null ? new List<String>.from(json['attchments']) : null,
      booking_id: json['booking_id'],
      created_at: json['created_at'],
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      id: json['id'],
      profile_image: json['profile_image'],
      rating: json['rating'],
      review: json['review'],
      service_id: json['service_id'],
      service_name: json['service_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.booking_id;
    data['created_at'] = this.created_at;
    data['customer_id'] = this.customer_id;
    data['customer_name'] = this.customer_name;
    data['id'] = this.id;
    data['profile_image'] = this.profile_image;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['service_id'] = this.service_id;
    data['service_name'] = this.service_name;
    if (this.attchments != null) {
      data['attchments'] = this.attchments;
    }
    return data;
  }
}
