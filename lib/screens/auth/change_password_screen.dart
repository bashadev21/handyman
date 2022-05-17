import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordCont = TextEditingController();
  TextEditingController newPasswordCont = TextEditingController();
  TextEditingController reenterPasswordCont = TextEditingController();

  FocusNode oldPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode reenterPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> changePassword() async {
    await setValue(USER_PASSWORD, newPasswordCont.text);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      var request = {
        UserKeys.oldPassword: oldPasswordCont.text,
        UserKeys.newPassword: newPasswordCont.text,
      };
      appStore.setLoading(true);

      await changeUserPassword(request).then((res) async {
        snackBar(context, title: res.message!);

        HomeScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
      }).catchError((e) {
        toast(e.toString(), print: true);
      });
      appStore.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language!.changePassword,
        textColor: white,
        color: context.primaryColor,
        elevation: 0.0,
        backWidget: BackWidget(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language!.lblChangePwdTitle, style: primaryTextStyle()),
                  24.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    controller: oldPasswordCont,
                    focus: oldPasswordFocus,
                    nextFocus: newPasswordFocus,
                    decoration: inputDecoration(context, hint: language!.hintOldPasswordTxt),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    controller: newPasswordCont,
                    focus: newPasswordFocus,
                    nextFocus: reenterPasswordFocus,
                    decoration: inputDecoration(context, hint: language!.hintNewPasswordTxt),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    controller: reenterPasswordCont,
                    focus: reenterPasswordFocus,
                    validator: (v) {
                      if (newPasswordCont.text != v) {
                        return language!.passwordNotMatch;
                      } else if (reenterPasswordCont.text.isEmpty) {
                        return errorThisFieldRequired;
                      }
                    },
                    onFieldSubmitted: (s) {
                      if (getStringAsync(USER_EMAIL) != email) {
                        changePassword();
                      } else {
                        snackBar(context, title: language!.lblUnAuthorized);
                        finish(context);
                      }
                    },
                    decoration: inputDecoration(context, hint: language!.hintReenterPasswordTxt),
                  ),
                  24.height,
                  AppButton(
                    text: language!.confirm,
                    height: 40,
                    color: primaryColor,
                    textStyle: primaryTextStyle(color: white),
                    width: context.width() - context.navigationBarHeight,
                    onTap: () {
                      if (getStringAsync(USER_EMAIL) != email) {
                        changePassword();
                      } else {
                        snackBar(context, title: language!.lblUnAuthorized);
                        //  finish(context);
                      }
                    },
                  ),
                  24.height,
                ],
              ),
            ),
          ),
          Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
