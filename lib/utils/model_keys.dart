class CommonKeys {
  static String id = 'id';
  static String address = 'address';
  static String serviceId = 'service_id';
  static String customerId = 'customer_id';
  static String providerId = 'provider_id';
  static String bookingId = 'booking_id';
  static String date = 'date';
  static String status = 'status';
  static String dateTime = 'datetime';
}

class UserKeys {
  static String firstName = 'first_name';
  static String lastName = 'last_name';
  static String userName = 'username';
  static String email = 'email';
  static String password = 'password';
  static String userType = 'user_type';
  static String contactNumber = 'contact_number';
  static String countryId = 'country_id';
  static String stateId = 'state_id';
  static String cityId = 'city_id';
  static String oldPassword = 'old_password';
  static String newPassword = 'new_password';
  static String profileImage = 'profile_image';
  static String playerId = 'player_id';
  static String uid = 'uid';
  static String id = 'id';
  static String loginType = 'login_type';
}

class BookingServiceKeys {
  static String description = 'description';
  static String couponId = 'coupon_id';
  static String date = 'date';
  static String totalAmount = 'total_amount';
}

class CouponKeys {
  static String code = 'code';
  static String discount = 'discount';
  static String discountType = 'discount_type';
  static String expireDate = 'expire_date';
}

class BookService {
  static String amount = 'amount';
  static String totalAmount = 'total_amount';
  static String quantity = 'quantity';
  static String bookingAddressId = 'booking_address_id';
}

class BookingStatusKeys {
  static String pending = 'pending';
  static String accept = 'accept';
  static String onGoing = 'on_going';
  static String inProgress = 'in_progress';
  static String hold = 'hold';
  static String rejected = 'rejected';
  static String failed = 'failed';
  static String complete = 'completed';
  static String cancelled = 'cancelled';
}

class BookingUpdateKeys {
  static String reason = 'reason';
  static String startAt = 'start_at';
  static String endAt = 'end_at';
  static String durationDiff = 'duration_diff';
}

class NotificationKey {
  static String type = 'type';
  static String page = 'page';
}

class CurrentLocationKey {
  static String latitude = 'latitude';
  static String longitude = 'longitude';
}
