class CityListResponse {
  int? id;
  String? name;
  int? state_id;

  CityListResponse({this.id, this.name, this.state_id});

  factory CityListResponse.fromJson(Map<String, dynamic> json) {
    return CityListResponse(
      id: json['id'],
      name: json['name'],
      state_id: json['state_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.state_id;
    return data;
  }
}
