import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/network/services/auth_services.dart';
import 'package:booking_system_flutter/screens/auth/sign_up_screen.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPDialog extends StatefulWidget {
  static String tag = '/OTPDialog';
  final String? verificationId;
  final String? phoneNumber;
  final bool? isCodeSent;
  final PhoneAuthCredential? credential;

  OTPDialog(
      {this.verificationId,
      this.isCodeSent,
      this.phoneNumber,
      this.credential});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends State<OTPDialog> {
  AuthServices authService = AuthServices();
  TextEditingController numberController = TextEditingController();

  String? countryCode = '';

  String otpCode = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> submit() async {
    appStore.setLoading(true);
    setState(() {});
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId!,
      smsCode: otpCode.validate(),
    );

    Map req = {
      "email": "",
      "username": widget.phoneNumber!.replaceAll('+', ''),
      "first_name": '',
      "last_name": '',
      "login_type": LoginTypeOTP,
      "user_type": "user",
      "accessToken": widget.phoneNumber!.replaceAll('+', ''),
    };

    await loginUser(req, isSocialLogin: true).then((value) async {
      setValue(LOGIN_TYPE, LoginTypeOTP);
      log(value.isUserExist);
      if (value.data != null) {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((result) async {
          finish(context);
          snackBar(context, title: language!.loginSuccessfully);
          HomeScreen().launch(context, isNewTask: true);
        }).catchError((e) {
          toast(e.toString(), print: true);
          appStore.setLoading(false);
          setState(() {});
        });
      } else if (!value.isUserExist.validate()) {
        appStore.setLoading(false);
        finish(context);
        SignUpScreen(
          phoneNumber: widget.phoneNumber!.replaceAll('+', ''),
          otpCode: otpCode.validate(),
          verificationId: widget.verificationId!,
          isOTPLogin: true,
        ).launch(context);
      } else {
        finish(context);
        toast(language!.toastSorry);
      }
    }).catchError((e) {
      appStore.setLoading(false);
      setState(() {});
      if (e.toString().contains('invalid_username')) {
        finish(context);
        SignUpScreen(
          phoneNumber: widget.phoneNumber!.replaceAll('+', ''),
          otpCode: otpCode.validate(),
          verificationId: widget.verificationId!,
          isOTPLogin: true,
        ).launch(context);
      } else {
        toast(e.toString(), print: true);
      }
    });
  }

  Future<void> sendOTP() async {
    appStore.setLoading(true);
    if (numberController.text.trim().isEmpty) {
      return toast(language!.lblRequiredValidation);
    }

    setState(() {});
    String number = '+$countryCode${numberController.text.trim()}';
    if (!number.startsWith('+')) {
      number = '+$countryCode${numberController.text.trim()}';
    }
    log(numberController);
    await authService.loginWithOTP(context, number).then((value) {
      //
    }).catchError((e) {
      toast(e.toString(), print: true);
    });
    appStore.setLoading(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: !widget.isCodeSent.validate()
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language!.lblenterPhnNumber, style: boldTextStyle()),
                30.height,
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      CountryCodePicker(
                        initialSelection: '+91',
                        showCountryOnly: false,
                        showFlag: false,
                        showFlagDialog: true,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        textStyle: primaryTextStyle(),
                        onInit: (c) {
                          countryCode = c!.dialCode;
                        },
                        onChanged: (c) {
                          countryCode = c.dialCode;
                        },
                      ),
                      8.width,
                      AppTextField(
                        controller: numberController,
                        textFieldType: TextFieldType.PHONE,
                        decoration: inputDecoration(context),
                        autoFocus: true,
                        onFieldSubmitted: (s) {
                          sendOTP();
                        },
                      ).expand(),
                    ],
                  ),
                ),
                30.height,
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppButton(
                      onTap: () {
                        sendOTP();
                      },
                      text: language!.btnSendOtp,
                      color: primaryColor,
                      textStyle: boldTextStyle(color: white),
                      width: context.width(),
                    ),
                    Positioned(
                      child: LoaderWidget().visible(appStore.isLoading),
                    )
                  ],
                )
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(language!.enterOtp, style: boldTextStyle()),
                30.height,
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 35,
                  style: primaryTextStyle(),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onChanged: (s) {
                    otpCode = s;
                  },
                  onCompleted: (pin) {
                    otpCode = pin;
                    submit();
                  },
                ).fit(),
                30.height,
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppButton(
                      onTap: () {
                        submit();
                      },
                      text: language!.confirm,
                      color: primaryColor,
                      textStyle: boldTextStyle(color: white),
                      width: context.width(),
                    ),
                    Positioned(
                      child: LoaderWidget().visible(appStore.isLoading),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
