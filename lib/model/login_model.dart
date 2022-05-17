import 'package:booking_system_flutter/model/user_model.dart';

class LoginResponse {
  UserData? data;
  bool? isUserExist;

  LoginResponse({this.data, this.isUserExist});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(data: json['data'] != null ? UserData.fromJson(json['data']) : null, isUserExist: json['is_user_exist']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['is_user_exist'] = this.isUserExist;
    return data;
  }
}
