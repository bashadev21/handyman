import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(primaryColor),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.workSans().fontFamily,
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
    iconTheme: IconThemeData(color: appTextSecondaryColor),
    textTheme: GoogleFonts.workSansTextTheme(),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: borderColor,
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
      backgroundColor: Colors.white,
    ),
    cardColor: cardColor,
    appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
    dialogTheme: DialogTheme(shape: dialogShape()),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(primaryColor),
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.workSans().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: GoogleFonts.workSansTextTheme(),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.white60,
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
      backgroundColor: scaffoldSecondaryDark,
    ),
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,
    dialogTheme: DialogTheme(shape: dialogShape()),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
/*

static final ThemeData lightTheme = ThemeData(
  primarySwatch: createMaterialColor(primaryColor),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
  iconTheme: IconThemeData(color: scaffoldSecondaryDark),
  textTheme: GoogleFonts.workSansTextTheme(),
  dialogBackgroundColor: Colors.white,
  unselectedWidgetColor: Colors.black,
  dividerColor: viewLineColor,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
    backgroundColor: Colors.white,
  ),
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  ),
  dialogTheme: DialogTheme(shape: dialogShape()),
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

static final ThemeData darkTheme = ThemeData(
  primarySwatch: createMaterialColor(primaryColor),
  primaryColor: scaffoldSecondaryDark,
  accentColor: Colors.red,
  appBarTheme: AppBarTheme(
    //color: appBackgroundColorDark,
    //iconTheme: IconThemeData(color: white),
    systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  ),
  scaffoldBackgroundColor: scaffoldColorDark,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: GoogleFonts.workSansTextTheme(),
  dialogBackgroundColor: scaffoldSecondaryDark,
  unselectedWidgetColor: Colors.white60,
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
    backgroundColor: scaffoldSecondaryDark,
  ),
  dividerColor: Colors.white12,
  cardColor: scaffoldSecondaryDark,
  dialogTheme: DialogTheme(shape: dialogShape()),
).copyWith(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
}

*/
