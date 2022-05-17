import 'package:nb_utils/nb_utils.dart';

//region APP NAME
const mAppName = 'N2';
//endregion

//region Common Configs
const decimalPoint = 2;
const perPageItem = 20;
const defaultLanguage = 'en';
//endregion

//region URLS & KEYS
//const url = 'https://wordpress.iqonic.design/product/mobile/booking-service';
const url = 'https://drfsc.in/test/N2/api/';
const mBaseUrl = 'https://drfsc.in/test/N2/api/';

const mOneSignalAppId = '083b49d3-49d9-40e0-9569-2725ac11b989';
const mOneSignalChannelId = "0ee01f0d-2e1c-4554-9050-27dd9c020292";
const mOneSignalRestKey = "ODMxOWU1MGYtMmU1Mi00MWZjLWI1YTMtNzQ1M2I2ZmU4ZmMx";

const termsConditionUrl = 'https://iqonic.design/terms-of-use/';
const privacyPolicyUrl = 'https://iqonic.design/privacy-policy/';
const helpSupportUrl = 'https://iqonic.desky.support/';
const purchaseUrl =
    'https://codecanyon.net/item/handyman-service-flutter-ondemand-home-services-app-with-complete-solution/33776097?s_rank=16';
//endregion

//region PlayStore And AppStore URL
const playStoreUrl = 'https://play.google.com/store/apps/details?id=';
const appStoreBaseUrl = 'https://www.apple.com/app-store/';
//endregion

//region MESSAGES
var passwordLengthMsg =
    'Password length should be more than $passwordLengthGlobal';
//endregion

const ONESIGNAL_TAG_KEY = 'appType';
const ONESIGNAL_TAG_VALUE = 'userApp';

//region LIVESTREAM KEYS
const tokenStream = 'tokenStream';
const streamTab = 'streamTab';
const streamUpdateBookingList = "UpdateBookingList";
const streamUpdateDashboard = "streamUpdateDashboard";
//endregion

//region default USER login
const DEFAULT_EMAIL = 'demo@user.com';
const DEFAULT_PASS = '12345678';
//endregion

//region THEME MODE TYPE
const ThemeModeLight = 0;
const ThemeModeDark = 1;
const ThemeModeSystem = 2;
//endregion

//region SHARED PREFERENCES KEYS
const IS_FIRST_TIME = 'IsFirstTime';
const IS_LOGGED_IN = 'IS_LOGGED_IN';
const USER_ID = 'USER_ID';
const FIRST_NAME = 'FIRST_NAME';
const LAST_NAME = 'LAST_NAME';
const USER_EMAIL = 'USER_EMAIL';
const USER_PASSWORD = 'USER_PASSWORD';
const PROFILE_IMAGE = 'PROFILE_IMAGE';
const IS_REMEMBERED = "IS_REMEMBERED";
const TOKEN = 'TOKEN';
const USERNAME = 'USERNAME';
const DISPLAY_NAME = 'DISPLAY_NAME';
const CONTACT_NUMBER = 'CONTACT_NUMBER';
const COUNTRY_ID = 'COUNTRY_ID';
const STATE_ID = 'STATE_ID';
const CITY_ID = 'CITY_ID';
const ADDRESS = 'ADDRESS';
const PLAYERID = 'PLAYERID';
const UID = 'UID';
const LATITUDE = 'LATITUDE';
const LONGITUDE = 'LONGITUDE';
const CURRENT_ADDRESS = 'CURRENT_ADDRESS';
const LOGIN_TYPE = 'LOGIN_TYPE';
const PAYMENT_LIST = 'PAYMENT_LIST';
const PRIVACY_POLICY = 'PRIVACY_POLICY';
const TERM_CONDITIONS = 'TERM_CONDITIONS';
const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
const HELPLINE_NUMBER = 'HELPLINE_NUMBER';

//endregion

//region CONFIGURATION KEYS
const CURRENCY_COUNTRY_SYMBOL = 'CURRENCY_COUNTRY_SYMBOL';
const CURRENCY_COUNTRY_CODE = 'CURRENCY_COUNTRY_CODE';
const CURRENCY_COUNTRY_ID = 'CURRENCY_COUNTRY_ID';
const IS_CURRENT_LOCATION = 'CURRENT_LOCATION';
//endregion

//region LOGIN TYPE
const LoginTypeUser = 'user';
const LoginTypeGoogle = 'google';
const LoginTypeOTP = 'mobile';
//endregion

//region SERVICE TYPE
const SERVICE_TYPE_FIXED = 'fixed';
const SERVICE_TYPE_PERCENT = 'percent';
const SERVICE_TYPE_HOURLY = 'hourly';
//endregion

//region PAYMENT METHOD
const PAYMENT_METHOD_COD = 'cash';
const PAYMENT_METHOD_STRIPE = 'stripe';
const PAYMENT_METHOD_RAZOR = 'razorPay';
const PAYMENT_METHOD_PAYSTACK = 'paystack';
const PAYMENT_METHOD_FLUTTER_WAVE = 'flutterwave';
//endregion

//region SERVICE PAYMENT STATUS
const SERVICE_PAYMENT_STATUS_PAID = 'paid';
const SERVICE_PAYMENT_STATUS_PENDING = 'pending';
//endregion

const MarkAsRead = 'markas_read';
//endregion

//region DEMO USER EMAIL
const email = "demo@user.com";
//endregion

//region FireBase Collection Name
const MESSAGES_COLLECTION = "messages";
const USER_COLLECTION = "users";
const CONTACT_COLLECTION = "contact";
const CHAT_DATA_IMAGES = "chatImages";

const IS_ENTER_KEY = "IS_ENTER_KEY";
const SELECTED_WALLPAPER = "SELECTED_WALLPAPER";
const PER_PAGE_CHAT_COUNT = 50;
//endregion

//region FILE TYPE
const TEXT = "TEXT";
const IMAGE = "IMAGE";

const VIDEO = "VIDEO";
const AUDIO = "AUDIO";
//endregion

//region CHAT LANGUAGE
List<String> RTLLanguage = ['ar', 'ur'];
//endregion

//region MessageType
enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
  AUDIO,
}
//endregion

//region MessageExtension
extension MessageExtension on MessageType {
  String? get name {
    switch (this) {
      case MessageType.TEXT:
        return 'TEXT';
      case MessageType.IMAGE:
        return 'IMAGE';
      case MessageType.VIDEO:
        return 'VIDEO';
      case MessageType.AUDIO:
        return 'AUDIO';
      default:
        return null;
    }
  }
}
//endregion

//region DateFormat
const DATE_FORMAT_1 = 'dd-MMM-yyyy hh:mm a';
const DATE_FORMAT_2 = 'd MMM, yyyy';
const DATE_FORMAT_3 = 'dd-MMM-yyyy';
const Hour12Format = 'hh:mm a';
const DATE_FORMAT_4 = 'd MMM';
const YEAR = 'yyyy';
const bookingSaveFormat = "yyyy-MM-dd kk:mm:ss";
//endregion

const STRIPE_PAYMENT_PUBLISH_KEY =
    'pk_test_51GrhA2Bz1ljKAgF98fI6WfB2YUn4CewOB0DNQC1pSeXspUc1LlUYs3ou19oPF0ATcqa52FXTYmv6v0mkvPZb9BSD00SUpBj9tI';
const permissionStatus = 'permissionStatus';

//region Mail And Tel URL
const MAIL_TO = 'mailto:';
const TEL = 'tel:';
//endregion