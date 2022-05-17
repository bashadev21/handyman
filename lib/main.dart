import 'dart:async';

import 'package:booking_system_flutter/app_theme.dart';
import 'package:booking_system_flutter/locale/app_localizations.dart';
import 'package:booking_system_flutter/locale/languages.dart';
import 'package:booking_system_flutter/network/services/chat_messages_service.dart';
import 'package:booking_system_flutter/network/services/notification_service.dart';
import 'package:booking_system_flutter/network/services/user_services.dart';
import 'package:booking_system_flutter/screens/no_internet_screen.dart';
import 'package:booking_system_flutter/screens/splash_screen.dart';
import 'package:booking_system_flutter/store/app_store.dart';
import 'package:booking_system_flutter/store/filter_store.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'model/file_model.dart';

AppStore appStore = AppStore();
FilterStore filterStore = FilterStore();
BaseLanguage? language;

UserService userService = UserService();
ChatMessageService chatMessageService = ChatMessageService();
NotificationService notificationService = NotificationService();

late List<FileModel> fileList = [];

String mSelectedImage = ic_default_wallpaper;

bool mIsEnterKey = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());
  forceEnableDebug = true;

  Firebase.initializeApp().then((value) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  });

  passwordLengthGlobal = 8;
  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;
  textSecondaryColorGlobal = appTextPrimaryColor;
  textPrimaryColorGlobal = appTextSecondaryColor;
  defaultAppButtonElevation = 0;

  await appStore.setLanguage(
      getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage));
  await appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == ThemeModeLight) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == ThemeModeDark) {
    appStore.setDarkMode(true);
  }

  OneSignal.shared.setAppId(mOneSignalAppId).then((value) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared.sendTag(ONESIGNAL_TAG_KEY, ONESIGNAL_TAG_VALUE);
    saveOneSignalPlayerId();
  });

  if (appStore.isLoggedIn) {
    await appStore.setUserId(getIntAsync(USER_ID), isInitializing: true);
    await appStore.setFirstName(getStringAsync(FIRST_NAME),
        isInitializing: true);
    await appStore.setLastName(getStringAsync(LAST_NAME), isInitializing: true);
    await appStore.setUserEmail(getStringAsync(USER_EMAIL),
        isInitializing: true);
    await appStore.setUserName(getStringAsync(USERNAME), isInitializing: true);
    await appStore.setContactNumber(getStringAsync(CONTACT_NUMBER),
        isInitializing: true);
    await appStore.setUserProfile(getStringAsync(PROFILE_IMAGE),
        isInitializing: true);
    await appStore.setCountryId(getIntAsync(COUNTRY_ID), isInitializing: true);
    await appStore.setStateId(getIntAsync(STATE_ID), isInitializing: true);
    await appStore.setCityId(getIntAsync(COUNTRY_ID), isInitializing: true);
    await appStore.setUId(getStringAsync(UID), isInitializing: true);
    await appStore.setToken(getStringAsync(TOKEN), isInitializing: true);
    await appStore.setAddress(getStringAsync(ADDRESS), isInitializing: true);
    await appStore.setCurrencyCode(getStringAsync(CURRENCY_COUNTRY_CODE),
        isInitializing: true);
    await appStore.setCurrencyCountryId(getStringAsync(CURRENCY_COUNTRY_ID),
        isInitializing: true);
    await appStore.setCurrencySymbol('₹', isInitializing: true);
    await appStore.setPrivacyPolicy(getStringAsync(PRIVACY_POLICY),
        isInitializing: true);
    await appStore.setTermConditions(getStringAsync(TERM_CONDITIONS),
        isInitializing: true);
    await appStore.setInquiryEmail(getStringAsync(INQUIRY_EMAIL),
        isInitializing: true);
    await appStore.setHelplineNumber(getStringAsync(HELPLINE_NUMBER),
        isInitializing: true);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((e) {
      if (e == ConnectivityResult.none) {
        log('Not connected');
        push(NoInternetScreen());
      } else {
        finish(context);
        log('Connected');
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: SplashScreen(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [
          AppLocalizations(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguageCode),
      ),
    );
  }
}
