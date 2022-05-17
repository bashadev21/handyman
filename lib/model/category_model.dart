import 'package:booking_system_flutter/model/dashboard_model.dart';
import 'package:booking_system_flutter/model/pagination_model.dart';

class CategoryResponse {
  List<Category>? data;
  Pagination? pagination;

  CategoryResponse({this.data, this.pagination});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => Category.fromJson(i)).toList() : null,
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
