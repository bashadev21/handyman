import 'dart:convert';

import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/component/otp_dialog.dart';
import 'package:booking_system_flutter/component/selected_item_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/profile_update_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/network/services/auth_services.dart';
import 'package:booking_system_flutter/screens/auth/forgot_password_screen.dart';
import 'package:booking_system_flutter/screens/auth/sign_up_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  final bool? isFromDashboard;
  final bool? isFromServiceBooking;

  SignInScreen({this.isFromDashboard, this.isFromServiceBooking});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthServices authService = AuthServices();

  TextEditingController emailCont = TextEditingController(text: kReleaseMode ? '' : '');
  TextEditingController passwordCont = TextEditingController(text: kReleaseMode ? '' : '');

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  String? countryCode = '';
  bool isCodeSent = true;
  bool isRemember = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    isRemember = getBoolAsync(IS_REMEMBERED);
    if (isRemember) {
      emailCont.text = getStringAsync(USER_EMAIL);
      passwordCont.text = getStringAsync(USER_PASSWORD);
    }
    afterBuildCreated(
      () {
        if (getStringAsync(PLAYERID).isEmpty) saveOneSignalPlayerId();
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      var request = {
        UserKeys.email: emailCont.text,
        UserKeys.password: passwordCont.text,
        UserKeys.playerId: getStringAsync(PLAYERID),
      };

      if (isRemember) {
        await setValue(USER_EMAIL, emailCont.text);
        await setValue(USER_PASSWORD, passwordCont.text);
        await setValue(IS_REMEMBERED, isRemember);
      }

      appStore.setLoading(true);
      await loginUser(request).then((res) async {
        if (res.data!.uid.validate().isNotEmpty) {
          authService.signInWithEmailPassword(context, email: emailCont.text, password: passwordCont.text).then((value) {
            appStore.setLoading(false);

            if (res.data != null) saveUserData(res.data!);

            toast(language!.loginSuccessfully);

            if (res.data!.status.validate() != 0) {
              if (res.data!.user_type == LoginTypeUser) {
                if (widget.isFromDashboard.validate()) {
                  setStatusBarColor(context.primaryColor);
                  finish(context, true);
                  return;
                }
                HomeScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
              } else {
                toast(language!.cantLogin);
              }
            } else {
              toast(language!.contactAdmin);
            }
          });
        } else {
          authService.signInWithEmailPassword(context, email: emailCont.text, password: passwordCont.text).then(
            (value) async {
              snackBar(context, title: language!.loginSuccessfully);
              if (res.data != null) saveUserData(res.data!);

              if (res.data!.status.validate() != 0) {
                if (res.data!.user_role!.first == LoginTypeUser) {
                  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
                  multiPartRequest.fields[UserKeys.uid] = getStringAsync(UID);

                  multiPartRequest.headers.addAll(buildHeaderTokens());
                  appStore.setLoading(true);
                  sendMultiPartRequest(
                    multiPartRequest,
                    onSuccess: (data) async {
                      appStore.setLoading(false);
                      if (data != null) {
                        if ((data as String).isJson()) {
                          ProfileUpdateResponse res = ProfileUpdateResponse.fromJson(jsonDecode(data));
                          saveUserData(res.data!);

                          if (res.data!.status.validate() != 0) {
                            if (res.data!.user_type == LoginTypeUser) {
                              if (widget.isFromDashboard.validate()) {
                                setStatusBarColor(context.primaryColor);
                                finish(context);
                                return;
                              }
                              HomeScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
                            } else {
                              toast(language!.cantLogin);
                            }
                          } else {
                            toast(language!.contactAdmin);
                          }
                        }
                      }
                    },
                    onError: (error) {
                      toast(error.toString(), print: true);
                      appStore.setLoading(false);
                    },
                  );
                } else {
                  toast(language!.cantLogin);
                }
              } else {
                toast(language!.contactAdmin);
              }
            },
          );
        }
      }).catchError((e) {
        toast(e.toString(), print: true);
      });
      appStore.setLoading(false);
    }
  }

  @override
  void dispose() {
    if (widget.isFromServiceBooking.validate()) {
      setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    if (widget.isFromDashboard.validate()) {
      setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.dark);
    }
    setStatusBarColor(primaryColor, statusBarIconBrightness: Brightness.light);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        elevation: 0,
        showBack: false,
        color: context.scaffoldBackgroundColor,
        backWidget: BackWidget(),
        systemUiOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark, statusBarColor: context.scaffoldBackgroundColor),
      ),
      body: SizedBox(
        width: context.width(),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.height,
                    Text("${language!.lblLoginTitle}!", style: boldTextStyle(size: 24)).center(),
                    16.height,
                    Text(language!.lblLoginSubTitle, style: primaryTextStyle(size: 18), textAlign: TextAlign.center).center().paddingSymmetric(horizontal: 32),
                    64.height,
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: emailCont,
                      focus: emailFocus,
                      nextFocus: passwordFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintEmailTxt),
                      suffix: ic_message.iconImage(size: 10).paddingAll(14),
                      autoFillHints: [AutofillHints.email],
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: passwordCont,
                      focus: passwordFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintPasswordTxt),
                      onFieldSubmitted: (s) {
                        login();
                      },
                    ),
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            2.width,
                            SelectedItemWidget(isSelected: isRemember).onTap(() async {
                              await setValue(IS_REMEMBERED, isRemember);
                              isRemember = !isRemember;
                              setState(() {});
                            }),
                            TextButton(
                              onPressed: () async {
                                await setValue(IS_REMEMBERED, isRemember);
                                isRemember = !isRemember;
                                setState(() {});
                              },
                              child: Text(language!.rememberMe, style: secondaryTextStyle()),
                            ),
                          ],
                        ),
                     /*   Row(
                          children: [
                            2.width,
                            SelectedItemWidget(isSelected: getBoolAsync(IS_REMEMBERED, defaultValue: true)).onTap(() async {
                              await setValue(IS_REMEMBERED, !getBoolAsync(IS_REMEMBERED));
                              setState(() {});
                            }),
                            TextButton(
                              onPressed: () async {
                                await setValue(IS_REMEMBERED, !getBoolAsync(IS_REMEMBERED));
                                setState(() {});
                              },
                              child: Text(language!.rememberMe, style: secondaryTextStyle()),
                            ),
                          ],
                        ),*/
                        TextButton(
                          onPressed: () {
                            showInDialog(
                              context,
                              contentPadding: EdgeInsets.zero,
                              dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM,
                              builder: (_) => ForgotPasswordScreen(),
                            );
                          },
                          child: Text(
                            language!.forgotPassword,
                            style: boldTextStyle(color: primaryColor, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    24.height,
                    AppButton(
                      text: language!.btnTextLogin,
                      color: primaryColor,
                      textStyle: boldTextStyle(color: white),
                      width: context.width() - context.navigationBarHeight,
                      onTap: () {
                        login();
                      },
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(language!.doNotHaveAccount, style: secondaryTextStyle()),
                        TextButton(
                          onPressed: () {
                            SignUpScreen(isOTPLogin: false).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                          },
                          child: Text(
                            language!.txtCreateAccount,
                            style: boldTextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                    64.height,
                    Row(
                      children: [
                        Divider(color: context.dividerColor, thickness: 2).expand(),
                        16.width,
                        Text(language!.lblOrContinueWith, style: secondaryTextStyle()),
                        16.width,
                        Divider(color: context.dividerColor, thickness: 2).expand(),
                      ],
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: primaryColor.withOpacity(0.1),
                            boxShape: BoxShape.circle,
                          ),
                          child: GoogleLogoWidget(size: 24).onTap(() async {
                            hideKeyboard(context);

                            appStore.setLoading(true);

                            await authService.signInWithGoogle().then((user) async {
                              await appStore.setLoggedIn(true);
                              HomeScreen().launch(context, isNewTask: true);
                            }).catchError((e) {
                              toast(e.toString(), print: true);
                            });

                            appStore.setLoading(false);
                          }),
                        ),
                        28.width,
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: primaryColor.withOpacity(0.1),
                            boxShape: BoxShape.circle,
                          ),
                          child: ic_calling.iconImage(color: primaryColor).paddingAll(4).onTap(
                            () async {
                              hideKeyboard(context);

                              appStore.setLoading(true);

                              await showInDialog(context, builder: (context) => OTPDialog(), barrierDismissible: false).catchError(
                                (e) {
                                  toast(e.toString());
                                },
                              );

                              appStore.setLoading(false);
                              //voidCallback?.call();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading))
          ],
        ),
      ),
    );
  }
}
