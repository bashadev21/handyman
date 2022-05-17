import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class Service {
  int? id;
  String? name;
  int? category_id;
  int? provider_id;
  num? price;
  String? price_format;
  String? type;
  num? discount;
  String? duration;
  int? status;
  String? description;
  int? is_featured;
  String? provider_name;
  String? category_name;
  List<String>? attchments;
  num? total_review;
  num? total_rating;
  int? isFavourite;
  List<ServiceAddressMapping>? serviceAddressMapping;

  String? providerImage;
  int? city_id;

  //Local
  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;

  Service({
    this.attchments,
    this.category_id,
    this.category_name,
    this.city_id,
    this.description,
    this.discount,
    this.duration,
    this.id,
    this.is_featured,
    this.name,
    this.price,
    this.price_format,
    this.provider_id,
    this.provider_name,
    this.status,
    this.total_rating,
    this.total_review,
    this.providerImage,
    this.type,
    this.isFavourite,
    this.serviceAddressMapping,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      attchments: json['attchments'] != null ? new List<String>.from(json['attchments']) : null,
      category_id: json['category_id'],
      category_name: json['category_name'],
      city_id: json['city_id'],
      description: json['description'],
      discount: json['discount'],
      duration: json['duration'],
      id: json['id'],
      is_featured: json['is_featured'],
      name: json['name'],
      price: json['price'],
      price_format: json['price_format'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      status: json['status'],
      total_rating: json['total_rating'],
      total_review: json['total_review'],
      providerImage: json['provider_image'],
      type: json['type'],
      isFavourite: json['is_favourite'],
      serviceAddressMapping: json['service_address_mapping'] != null ? (json['service_address_mapping'] as List).map((i) => ServiceAddressMapping.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.category_id;
    data['category_name'] = this.category_name;
    data['city_id'] = this.city_id;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['is_featured'] = this.is_featured;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_format'] = this.price_format;
    data['provider_id'] = this.provider_id;
    data['provider_name'] = this.provider_name;
    data['status'] = this.status;
    data['total_rating'] = this.total_rating;
    data['total_review'] = this.total_review;
    data['provider_image'] = this.providerImage;

    data['type'] = this.type;
    if (this.attchments != null) {
      data['attchments'] = this.attchments;
    }
    data['is_favourite'] = this.isFavourite;
    if (this.serviceAddressMapping != null) {
      data['service_address_mapping'] = this.serviceAddressMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceAddressMapping {
  int? id;
  int? serviceId;
  int? providerAddressId;
  String? createdAt;
  String? updatedAt;
  ProviderAddressMapping? providerAddressMapping;

  ServiceAddressMapping({this.id, this.serviceId, this.providerAddressId, this.createdAt, this.updatedAt, this.providerAddressMapping});

  ServiceAddressMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    providerAddressId = json['provider_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    providerAddressMapping = json['provider_address_mapping'] != null ? new ProviderAddressMapping.fromJson(json['provider_address_mapping']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['provider_address_id'] = this.providerAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.providerAddressMapping != null) {
      data['provider_address_mapping'] = this.providerAddressMapping!.toJson();
    }
    return data;
  }
}

class ProviderAddressMapping {
  int? id;
  int? providerId;
  String? address;
  String? latitude;
  String? longitude;
  var status;
  String? createdAt;
  String? updatedAt;

  ProviderAddressMapping({this.id, this.providerId, this.address, this.latitude, this.longitude, this.status, this.createdAt, this.updatedAt});

  ProviderAddressMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
