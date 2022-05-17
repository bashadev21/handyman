import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/network/services/auth_services.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;
  final bool? isOTPLogin;
  final String? verificationId;
  final String? otpCode;

  SignUpScreen({this.phoneNumber, this.isOTPLogin = false, this.otpCode, this.verificationId});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthServices authService = AuthServices();

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController cPasswordCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode cPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    mobileCont.text = widget.phoneNumber != null ? widget.phoneNumber.toString() : "";
    passwordCont.text = widget.phoneNumber != null ? widget.phoneNumber.toString() : "";
    userNameCont.text = widget.phoneNumber != null ? widget.phoneNumber.toString() : "";
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      appStore.setLoading(true);
      await authService
          .signUpWithEmailPassword(
        context,
        lName: lNameCont.text,
        userName: widget.phoneNumber ?? userNameCont.text,
        name: fNameCont.text.trim(),
        email: emailCont.text.trim(),
        password: widget.phoneNumber ?? passwordCont.text.trim(),
        mobileNumber: widget.phoneNumber ?? mobileCont.text.trim(),
      )
          .then((res) async {
        appStore.setLoading(false);
        //
      }).catchError((e) {
        appStore.setLoading(false);
        log('error...: ${e.toString()}');
        toast(e.toString(), print: true);
      });
    }
  }

  Future<void> registerWithOTP() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      appStore.setLoading(true);
      authService
          .signUpWithOTP(context,
              lName: lNameCont.text,
              userName: widget.phoneNumber,
              name: fNameCont.text.trim(),
              email: emailCont.text.trim(),
              password: widget.phoneNumber,
              mobileNumber: widget.phoneNumber,
              otpCode: widget.otpCode,
              verificationId: widget.verificationId)
          .then((res) async {
        appStore.setLoading(false);
        //
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    }
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkMode ? black : white, delayInMilliSeconds: 500);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        elevation: 0,
        color: context.scaffoldBackgroundColor,
        backWidget: BackWidget(iconColor: context.iconColor),
        systemUiOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark, statusBarColor: context.scaffoldBackgroundColor),
      ),
      body: SizedBox(
        width: context.width(),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      padding: EdgeInsets.all(16),
                      child: ic_profile2.iconImage(color: Colors.white),
                      decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor),
                    ),
                    16.height,
                    Text(language!.lblHelloUser, style: boldTextStyle(size: 24)).center(),
                    16.height,
                    Text(language!.lblSignUpSubTitle, style: primaryTextStyle(size: 18), textAlign: TextAlign.center).center().paddingSymmetric(horizontal: 32),
                    64.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: fNameCont,
                      focus: fNameFocus,
                      nextFocus: lNameFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintFirstNameTxt),
                      suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: lNameCont,
                      focus: lNameFocus,
                      nextFocus: userNameFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintLastNameTxt),
                      suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.USERNAME,
                      controller: userNameCont,
                      focus: userNameFocus,
                      nextFocus: emailFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintUserNameTxt),
                      suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: emailCont,
                      focus: emailFocus,
                      errorThisFieldRequired: language!.requiredText,
                      nextFocus: mobileFocus,
                      decoration: inputDecoration(context, hint: language!.hintEmailTxt),
                      suffix: ic_message.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: passwordCont,
                      focus: passwordFocus,
                      errorThisFieldRequired: language!.requiredText,
                      decoration: inputDecoration(context, hint: language!.hintPasswordTxt),
                      onFieldSubmitted: (s) {
                        if (widget.isOTPLogin == false)
                          register();
                        else
                          registerWithOTP();
                      },
                    ),
                    16.height,
                    AppTextField(
                        textFieldType: TextFieldType.PHONE,
                        controller: mobileCont,
                        focus: mobileFocus,
                        errorThisFieldRequired: language!.requiredText,
                        nextFocus: passwordFocus,
                        decoration: inputDecoration(context, hint: language!.hintContactNumberTxt),
                        suffix: ic_calling.iconImage(size: 10).paddingAll(14),
                        validator: (mobileCont) {
                          String value = mobileCont.toString();
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (value.length == 0) {
                            return language!.phnrequiredtext;
                          } else if (!regExp.hasMatch(value.toString())) {
                            return language!.phnvalidation;
                          }
                        }),

                    64.height,
                    AppButton(
                      text: language!.signUp,
                      color: primaryColor,
                      textStyle: boldTextStyle(color: white),
                      width: context.width() - context.navigationBarHeight,
                      onTap: () {
                        log(widget.isOTPLogin);
                        if (widget.isOTPLogin == false)
                          register();
                        else
                          registerWithOTP();
                      },
                    ),
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(language!.alreadyHaveAccountTxt, style: secondaryTextStyle()),
                        4.width,
                        TextButton(
                          onPressed: () {
                            finish(context);
                          },
                          child: Text(
                            language!.lblSignInHere,
                            style: boldTextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
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
