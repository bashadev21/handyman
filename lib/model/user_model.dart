class UserData {
  String? uid;
  String? address;
  String? api_token;
  int? city_id;
  String? contact_number;
  int? country_id;
  String? created_at;
  String? display_name;
  String? email;
  String? email_verified_at;
  String? first_name;
  String? last_name;
  String? player_id;
  var provider_id;
  String? providertype_id;
  int? state_id;
  String? updated_at;
  String? user_type;
  String? username;
  String? profile_image;
  int? id;
  int? status;
  String? description;
  String? providertype;
  String? city_name;
  int? is_featured;
  List<String>? user_role;
  String? timeZone;
  String? loginType;
  int? serviceAddressId;
  String? lastNotificationSeen;
  num? providersServiceRating;
  num? handymanRating;
  HandymanReview? handymanReview;
  int? isVerifyProvider;
  int? isUserExist;

  UserData(
      {this.address,
      this.api_token,
      this.city_id,
      this.contact_number,
      this.country_id,
      this.created_at,
      this.display_name,
      this.email,
      this.email_verified_at,
      this.first_name,
      this.id,
      this.is_featured,
      this.last_name,
      this.player_id,
      this.description,
      this.providertype,
      this.city_name,
      this.provider_id,
      this.providertype_id,
      this.state_id,
      this.status,
      this.updated_at,
      this.user_role,
      this.user_type,
      this.username,
      this.profile_image,
      this.uid,
      this.handymanRating,
      this.handymanReview,
      this.lastNotificationSeen,
      this.loginType,
      this.providersServiceRating,
      this.serviceAddressId,
      this.timeZone,
      this.isVerifyProvider,
      this.isUserExist});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        address: json['address'],
        api_token: json['api_token'],
        city_id: json['city_id'],
        contact_number: json['contact_number'],
        country_id: json['country_id'],
        created_at: json['created_at'],
        display_name: json['display_name'],
        email: json['email'],
        email_verified_at: json['email_verified_at'],
        first_name: json['first_name'],
        id: json['id'],
        is_featured: json['is_featured'],
        last_name: json['last_name'],
        player_id: json['player_id'],
        provider_id: json['provider_id'],
        //providertype_id: json['providertype_id'],
        state_id: json['state_id'],
        status: json['status'],
        updated_at: json['updated_at'],
        user_role: json['user_role'] != null ? new List<String>.from(json['user_role']) : null,
        user_type: json['user_type'],
        username: json['username'],
        profile_image: json['profile_image'],
        uid: json['uid'],
        description: json['description'],
        providertype: json['providertype'],
        city_name: json['city_name'],
        loginType: json['login_type'],
        serviceAddressId: json['service_address_id'],
        lastNotificationSeen: json['last_notification_seen'],
        providersServiceRating: json['providers_service_rating'],
        handymanRating: json['handyman_rating'],
        handymanReview: json['handyman_review'] != null ? new HandymanReview.fromJson(json['handyman_review']) : null,
        timeZone: json['time_zone'],
        isVerifyProvider: json['is_verify_provider'],
        isUserExist: json['is_user_exist']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['api_token'] = this.api_token;
    data['city_id'] = this.city_id;
    data['contact_number'] = this.contact_number;
    data['country_id'] = this.country_id;
    data['created_at'] = this.created_at;
    data['display_name'] = this.display_name;
    data['email'] = this.email;
    data['email_verified_at'] = this.email_verified_at;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['is_featured'] = this.is_featured;
    data['last_name'] = this.last_name;
    data['player_id'] = this.player_id;
    data['provider_id'] = this.provider_id;
    data['providertype_id'] = this.providertype_id;
    data['state_id'] = this.state_id;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
    data['user_type'] = this.user_type;
    data['username'] = this.username;
    data['profile_image'] = this.profile_image;
    data['uid'] = this.uid;
    data['description'] = this.description;
    data['providertype'] = this.providertype;
    data['city_name'] = this.city_name;
    if (this.user_role != null) {
      data['user_role'] = this.user_role;
    }
    data['time_zone'] = this.timeZone;
    data['uid'] = this.uid;
    data['login_type'] = this.loginType;
    data['service_address_id'] = this.serviceAddressId;
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['providers_service_rating'] = this.providersServiceRating;
    data['handyman_rating'] = this.handymanRating;
    if (this.handymanReview != null) {
      data['handyman_review'] = this.handymanReview!.toJson();
    }
    data['is_verify_provider'] = this.isVerifyProvider;
    data['is_user_exist'] = this.isUserExist;
    return data;
  }
}

class HandymanReview {
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

  HandymanReview(
      {this.id,
      this.customerId,
      this.rating,
      this.review,
      this.serviceId,
      this.bookingId,
      this.handymanId,
      this.handymanName,
      this.handymanProfileImage,
      this.customerName,
      this.customerProfileImage,
      this.createdAt});

  HandymanReview.fromJson(Map<String, dynamic> json) {
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
