import 'package:booking_system_flutter/model/pagination_model.dart';
import 'package:booking_system_flutter/model/service_model.dart';

class SearchResponse {
  List<Service>? data;
  int? max;
  int? min;
  Pagination? pagination;

  SearchResponse({this.data, this.max, this.min, this.pagination});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => Service.fromJson(i)).toList() : null,
      max: json['max'],
      min: json['min'],
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['min'] = this.min;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}
