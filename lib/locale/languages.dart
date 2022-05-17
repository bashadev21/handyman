import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get walkTitle1;

  String get walkTitle2;

  String get walkTitle3;

  String get getStarted;

  String get welcomeTxt;

  String get signIn;

  String get signUp;

  String get signInTitle;

  String get signUpTitle;

  String get hintNameTxt;

  String get hintFirstNameTxt;

  String get hintLastNameTxt;

  String get hintContactNumberTxt;

  String get passwordErrorTxt;

  String get hintEmailAddressTxt;

  String get hintUserNameTxt;

  String get hintPasswordTxt;

  String get hintEmailTxt;

  String get hintConfirmPasswordTxt;

  String get forgotPassword;

  String get reset;

  String get signInWithTxt;

  String get alreadyHaveAccountTxt;

  String get rememberMe;

  String get forgotPasswordTitleTxt;

  String get resetPassword;

  String get dashboard;

  String get search;

  String get loginSuccessfully;

  String get saveChanges;

  String get camera;

  String get language;

  String get supportLanguage;

  String get appTheme;

  String get bookingHistory;

  String get rateUs;

  String get termsCondition;

  String get helpSupport;

  String get privacyPolicy;

  String get about;

  String get changePassword;

  String get logout;

  String get logoutTxt;

  String get editProfile;

  String get afterLogoutTxt;

  String get chooseTheme;

  String get selectCountry;

  String get selectState;

  String get selectCity;

  String get confirm;

  String get passwordNotMatch;

  String get doNotHaveAccount;

  String get hintReenterPasswordTxt;

  String get hintOldPasswordTxt;

  String get hintNewPasswordTxt;

  String get hintAddress;

  String get hintCouponCode;

  String get hintDescription;

  String get continueTxt;

  String get lblSeenMore;

  String get lblSeenLess;

  String get lblGallery;

  String get lblProvider;

  String get yourReview;

  String get review;

  String get lblAddress;

  String get lblCouponCode;

  String get lblDescription;

  String get lblNew;

  String get lblApply;

  String get bookTheService;

  String get cantLogin;

  String get contactAdmin;

  String get allServices;

  String get availableCoupon;

  String get duration;

  String get takeTime;

  String get hourly;

  String get providerDetail;

  String get contact;

  String get from;

  String get serviceList;

  String get serviceGallery;

  String get payment;

  String get done;

  String get paymentMethod;

  String get totalAmount;

  String get couponDiscount;

  String get discountOnMRP;

  String get quantity;

  String get rate;

  String get priceDetail;

  String get home;

  String get category;

  String get booking;

  String get profile;

  String get bookService;

  String get dateTime;

  String get selectDateTime;

  String get bookingSummary;

  String get bookingAt;

  String get lblAlertBooking;

  String get applyCoupon;

  String get bookingService;

  String get serviceName;

  String get customerName;

  String get expDate;

  String get discount;

  String get typeOfService;

  String get thingsInclude;

  String get safetyFee;

  String get itemTotal;

  String get loginToApply;

  String get service;

  String get viewAllService;

  String get lblCancelReason;

  String get lblreason;

  String get enterReason;

  String get noDataAvailable;

  String get contactProvider;

  String get contactHandyman;

  String get pricingDetail;

  String get lblOk;

  String get paymentDetail;

  String get paymentStatus;

  String get totalAmountPaid;

  String get viewDetail;

  String get bookingStatus;

  String get appThemeLight;

  String get appThemeDark;

  String get appThemeDefault;

  String get lblCheckInternet;

  String get markAsRead;

  String get deleteAll;

  String get lblInternetWait;

  String get toastPaymentFail;

  String get toastEnterDetail;

  String get toastEnterAddress;

  String get toastReason;

  String get lblComplete;

  String get lblHoldReason;

  String get cancelled;

  String get lblYes;

  String get lblNo;

  String get lblRateApp;

  String get lblRateTitle;

  String get lblHintRate;

  String get btnRate;

  String get btnLater;

  String get toastRateUs;

  String get toastAddReview;

  String get toastSorry;

  String get btnSubmit;

  String get walkThrough1;

  String get walkThrough2;

  String get walkThrough3;

  String get lblSkip;

  String get lnlNotification;

  String get lblUnAuthorized;

  String get btnNext;

  String get lblViewAll;

  String get notAvailable;

  String get serviceAvailable;

  String get WriteMsg;

  String get dltMsg;

  String get lblFavorite;

  String get lblchat;

  String get addAddess;

  String get allProvider;

  String get txtemail;

  String get getLocation;

  String get setAddress;

  String get requiredText;

  String get phnrequiredtext;

  String get phnvalidation;

  String get lblVeiwAll;

  String get toastLocationOff;

  String get toastLocationOn;

  String get PaymentConfirmation;

  String get lblCall;

  String get lblRateHandyman;

  String get msgForLocationOn;

  String get msgForLocationOff;

  String get btnCurrent;

  String get lblenterPhnNumber;

  String get btnSendOtp;

  String get enterOtp;

  String get lblLocationOff;

  String get ratings;

  String get lblAppSetting;

  String get lblVersion;

  String get txtProvider;

  String get lblShowMore;

  String get txtPassword;

  String get lblShowLess;

  String get lblSignInTitle;

  String get lblSignUpTitle;

  String get txtCreateAccount;

  String get lblSignInHere;

  String get lblTaxAmount;

  String get lblSubTotal;

  // Add data
  String get lblNoData;

  String get lblImage;

  String get lblVideo;

  String get lblAudio;

  String get lblChangePwdTitle;

  String get lblForgotPwdSubtitle;

  String get lblLoginTitle;

  String get lblLoginSubTitle;

  String get btnTextLogin;

  String get lblOrContinueWith;

  String get lblHelloUser;

  String get lblSignUpSubTitle;

  String get lblStepper1Title;

  String get lblDateAndTime;

  String get lblEnterDateAndTime;

  String get lblYourAddress;

  String get lblEnterYourAddress;

  String get lblUseCurrentLocation;

  String get lblEnterDescription;

  String get lblPrice;

  String get lblTax;

  String get lblDiscount;

  String get lblAvailableCoupons;

  String get lblPrevious;

  String get lblBook;

  String get lblCoupon;

  String get lblEditYourReview;

  String get lblTime;

  String get textProvider;

  String get lblConfirmBooking;

  String get lblConfirmMsg;

  String get lblCancel;

  String get lblExpiryDate;

  String get lblRemoveCoupon;

  String get lblNoCouponsAvailable;

  String get lblStep1;

  String get lblStep2;

  String get lblBookingID;

  String get lblDate;

  String get lblAboutHandyman;

  String get lblAboutProvider;

  String get lblRatedYet;

  String get lblDeleteReview;

  String get lblConfirmReviewSubTitle;

  String get lblConfirmService;

  String get lblConFirmResumeService;

  String get lblEndServicesMsg;

  String get lblCancelBooking;

  String get lblStart;

  String get lblHold;

  String get lblResume;

  String get lblPayNow;

  String get lblCheckStatus;

  String get lblID;

  String get lblNoBookingsFound;

  String get lblCategory;

  String get lblYourComment;

  String get lblIntroducingCustomerRating;

  String get lblSeeYourRatings;

  String get lblFeatured;

  String get lblNoServicesFound;

  String get lblNoChatFound;

  String get lblGENERAL;

  String get lblAboutApp;

  String get lblPurchaseCode;

  String get lblReviewsOnServices;

  String get lblNoRateYet;

  String get lblSetting;

  String get lblMemberSince;

  String get lblFilterBy;

  String get lblAllFiltersCleared;

  String get lblClearFilter;

  String get lblNumber;

  String get lblNoReviews;

  String get lblUnreadNotification;

  String get lblChoosePaymentMethod;

  String get lblNoPayments;

  String get lblPayWith;

  String get payWith;

  String get lblYourRating;

  String get lblEnterReview;

  String get lblDelete;

  String get lblDeleteRatingMsg;

  String get lblSelectRating;

  String get lblServiceRatings;

  String get lblNoServiceRatings;

  String get lblSearchFor;

  String get lblRating;

  String get lblAvailableAt;

  String get lblRelatedServices;

  String get lblBookNow;

  String get lblWelcomeToHandyman;

  String get lblWalkThroughSubTitle;

  String get textHandyman;

  String get lblChooseFromMap;

  String get lblAbout;

  String get lblDeleteAddress;

  String get lblDeleteSunTitle;

  String get lblFaq;

  String get lblServiceFaq;

  //ToDO Add Localitation
  String get lblLogoutTitle;
  String get lblLogoutSubTitle;
  String get lblFeaturedProduct;

  String get lblRequiredValidation;

  String get lblAlert;

  String get lblLocationOffMsg;

  String get lblOnBase;

  String get lblInvalidCoupon;

  String get lblSelectCode;

  String get lblBackPressMsg;

  String get lblHour;
}
