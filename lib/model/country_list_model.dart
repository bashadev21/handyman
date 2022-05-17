class CountryListResponse {
  String? code;
  String? currency_code;
  String? currency_name;
  int? dial_code;
  int? id;
  String? name;
  String? symbol;

  CountryListResponse({this.code, this.currency_code, this.currency_name, this.dial_code, this.id, this.name, this.symbol});

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
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
