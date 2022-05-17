import 'package:booking_system_flutter/model/pagination_model.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class WishListResponse {
  List<WishListData>? data;
  Pagination? pagination;

  WishListResponse({this.data, this.pagination});

  factory WishListResponse.fromJson(Map<String, dynamic> json) {
    return WishListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => WishListData.fromJson(i)).toList() : null,
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

class WishListData {
  num? id;
  int? category_id;
  String? category_name;
  String? created_at;
  String? customer_name;
  num? discount;
  String? duration;
  num? is_favourite;
  String? name;
  num? price;
  String? price_format;
  String? provider_image;
  String? provider_name;
  List<String>? service_attchments;
  num? service_id;
  num? total_rating;
  String? type;
  num? user_id;

  //Local
  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;

  WishListData({
    this.category_id,
    this.category_name,
    this.created_at,
    this.customer_name,
    this.discount,
    this.duration,
    this.id,
    this.is_favourite,
    this.name,
    this.price,
    this.price_format,
    this.provider_image,
    this.provider_name,
    this.service_attchments,
    this.service_id,
    this.total_rating,
    this.type,
    this.user_id,
  });

  factory WishListData.fromJson(Map<String, dynamic> json) {
    return WishListData(
      category_name: json['category_name'],
      category_id: json['category_id'],
      created_at: json['created_at'],
      customer_name: json['customer_name'],
      discount: json['discount'],
      duration: json['duration'],
      id: json['id'],
      is_favourite: json['is_favourite'],
      name: json['name'],
      price: json['price'],
      price_format: json['price_format'],
      provider_image: json['provider_image'],
      provider_name: json['provider_name'],
      service_attchments: json['service_attchments'] != null ? new List<String>.from(json['service_attchments']) : null,
      service_id: json['service_id'],
      total_rating: json['total_rating'],
      type: json['type'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.category_name;
    data['created_at'] = this.created_at;
    data['customer_name'] = this.customer_name;
    data['discount'] = this.discount;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['is_favourite'] = this.is_favourite;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_format'] = this.price_format;
    data['provider_image'] = this.provider_image;
    data['provider_name'] = this.provider_name;
    data['service_id'] = this.service_id;
    data['total_rating'] = this.total_rating;
    data['type'] = this.type;
    data['user_id'] = this.user_id;
    data['category_id'] = this.category_id;
    if (this.service_attchments != null) {
      data['service_attchments'] = this.service_attchments;
    }
    return data;
  }
}
