import 'package:booking_system_flutter/locale/app_localizations.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_status_model.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @observable
  bool isFavorite = false;

  @observable
  bool isCurrentLocation = false;

  @observable
  bool isRememberMe = false;

  @observable
  String selectedLanguageCode = defaultLanguage;

  @observable
  String userProfileImage = '';

  @observable
  String privacyPolicy = '';

  @observable
  String termConditions = '';

  @observable
  String inquiryEmail = '';

  @observable
  String helplineNumber = '';

  @observable
  String userFirstName = '';

  @observable
  String userLastName = '';

  @observable
  String uid = '';

  @observable
  String userContactNumber = '';

  @observable
  String userEmail = '';

  @observable
  String userName = '';

  @observable
  double latitude = 0.0;

  @observable
  double longitude = 0.0;

  @observable
  String currentAddress = '';

  @observable
  String token = '';

  @observable
  int countryId = 0;

  @observable
  int stateId = 0;

  @observable
  String currencySymbol = '';

  @observable
  String currencyCode = '';

  BookingStatusResponse? selectedStatus;

  @observable
  String currencyCountryId = '';

  @observable
  int cityId = 0;

  @observable
  String address = '';

  @observable
  String playerId = '';

  @computed
  String get userFullName => '$userFirstName $userLastName'.trim();

  @observable
  int? userId = -1;

  @observable
  int? unreadCount = 0;

  @observable
  @action
  Future<void> setPlayerId(String val, {bool isInitializing = false}) async {
    playerId = val;
    if (!isInitializing) await setValue(PLAYERID, val);
  }

  @action
  Future<void> setAddress(String val, {bool isInitializing = false}) async {
    address = val;
    if (!isInitializing) await setValue(ADDRESS, val);
  }

  @action
  Future<void> setUserProfile(String val, {bool isInitializing = false}) async {
    userProfileImage = val;
    if (!isInitializing) await setValue(PROFILE_IMAGE, val);
  }

  @action
  Future<void> setPrivacyPolicy(String val, {bool isInitializing = false}) async {
    privacyPolicy = val;
    if (!isInitializing) await setValue(PRIVACY_POLICY, val);
  }

  @action
  Future<void> setTermConditions(String val, {bool isInitializing = false}) async {
    termConditions = val;
    if (!isInitializing) await setValue(TERM_CONDITIONS, val);
  }

  @action
  Future<void> setInquiryEmail(String val, {bool isInitializing = false}) async {
    inquiryEmail = val;
    if (!isInitializing) await setValue(INQUIRY_EMAIL, val);
  }

  @action
  Future<void> setHelplineNumber(String val, {bool isInitializing = false}) async {
    helplineNumber = val;
    if (!isInitializing) await setValue(HELPLINE_NUMBER, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitializing = false}) async {
    token = val;
    if (!isInitializing) await setValue(TOKEN, val);
  }

  @action
  Future<void> setCountryId(int val, {bool isInitializing = false}) async {
    countryId = val;
    if (!isInitializing) await setValue(COUNTRY_ID, val);
  }

  @action
  Future<void> setBookingSelectedStatus(BookingStatusResponse val) async {
    selectedStatus = val;
  }

  @action
  Future<void> setStateId(int val, {bool isInitializing = false}) async {
    stateId = val;
    if (!isInitializing) await setValue(STATE_ID, val);
  }

  @action
  Future<void> setCurrencySymbol(String val, {bool isInitializing = false}) async {
    currencySymbol = val;
    if (!isInitializing) await setValue(CURRENCY_COUNTRY_SYMBOL, val);
  }

  @action
  Future<void> setCurrencyCode(String val, {bool isInitializing = false}) async {
    currencyCode = val;
    if (!isInitializing) await setValue(CURRENCY_COUNTRY_CODE, val);
  }

  @action
  Future<void> setCurrencyCountryId(String val, {bool isInitializing = false}) async {
    currencyCountryId = val;
    if (!isInitializing) await setValue(CURRENCY_COUNTRY_ID, val);
  }

  @action
  Future<void> setUId(String val, {bool isInitializing = false}) async {
    uid = val;
    if (!isInitializing) await setValue(UID, val);
  }

  @action
  Future<void> setCityId(int val, {bool isInitializing = false}) async {
    cityId = val;
    if (!isInitializing) await setValue(CITY_ID, val);
  }

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(USER_ID, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitializing = false}) async {
    userEmail = val;
    if (!isInitializing) await setValue(USER_EMAIL, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitializing = false}) async {
    userFirstName = val;
    if (!isInitializing) await setValue(FIRST_NAME, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitializing = false}) async {
    userLastName = val;
    if (!isInitializing) await setValue(LAST_NAME, val);
  }

  @action
  Future<void> setContactNumber(String val, {bool isInitializing = false}) async {
    userContactNumber = val;
    if (!isInitializing) await setValue(CONTACT_NUMBER, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitializing = false}) async {
    userName = val;
    if (!isInitializing) await setValue(USERNAME, val);
  }

  @action
  Future<void> setCurrentAddress(String val, {bool isInitializing = false}) async {
    currentAddress = val;
    if (!isInitializing) await setValue(CURRENT_ADDRESS, val);
  }

  @action
  Future<void> setLatitude(double val, {bool isInitializing = false}) async {
    latitude = val;
    await setValue(LATITUDE, val);
  }

  @action
  Future<void> setLongitude(double val, {bool isInitializing = false}) async {
    longitude = val;
    await setValue(LONGITUDE, val);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  void setFavorite(bool val) {
    isFavorite = val;
  }

  @action
  Future<void> setCurrentLocation(bool val, {bool isInitializing = false}) async {
    isCurrentLocation = val;
    if (!isInitializing) await setValue(IS_CURRENT_LOCATION, val);
  }

  @action
  void setUnreadCount(int val) {
    unreadCount = val;
  }

  @action
  void setRemember(bool val) {
    isRememberMe = val;
  }

  @action
  Future<void> setDarkMode(bool val) async {
    isDarkMode = val;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor;
      defaultLoaderBgColorGlobal = scaffoldSecondaryDark;
      appButtonBackgroundColorGlobal = appButtonColorDark;
      shadowColorGlobal = Colors.white12;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;
      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.black12;
    }
  }

  @action
  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    selectedLanguageDataModel = getSelectedLanguageModel();

    await setValue(SELECTED_LANGUAGE_CODE, selectedLanguageCode);

    language = await AppLocalizations().load(Locale(selectedLanguageCode));
    // errorInternetNotAvailable=language!.errorInternetNotAvailable;
  }
}
