class StateListResponse {
  int? country_id;
  int? id;
  String? name;

  StateListResponse({this.country_id, this.id, this.name});

  factory StateListResponse.fromJson(Map<String, dynamic> json) {
    return StateListResponse(
      country_id: json['country_id'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.country_id;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
