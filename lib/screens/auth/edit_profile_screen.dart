import 'dart:convert';
import 'dart:io';

import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/city_list_model.dart';
import 'package:booking_system_flutter/model/country_list_model.dart';
import 'package:booking_system_flutter/model/profile_update_model.dart';
import 'package:booking_system_flutter/model/state_list_model.dart';
import 'package:booking_system_flutter/network/network_utils.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/string_extensions.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:booking_system_flutter/utils/widgets/cached_nework_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? imageFile;
  PickedFile? pickedFile;

  List<CountryListResponse> countryList = [];
  List<StateListResponse> stateList = [];
  List<CityListResponse> cityList = [];

  CountryListResponse? selectedCountry;
  StateListResponse? selectedState;
  CityListResponse? selectedCity;

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();

  int countryId = 0;
  int stateId = 0;
  int cityId = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      appStore.setLoading(true);
    });

    countryId = getIntAsync(COUNTRY_ID).validate();
    stateId = getIntAsync(STATE_ID).validate();
    cityId = getIntAsync(CITY_ID).validate();

    fNameCont.text = appStore.userFirstName.validate();
    lNameCont.text = appStore.userLastName.validate();
    emailCont.text = appStore.userEmail.validate();
    userNameCont.text = appStore.userName.validate();
    mobileCont.text = '${appStore.userContactNumber.validate()}';
    countryId = appStore.countryId.validate();
    stateId = appStore.stateId.validate();
    cityId = appStore.cityId.validate();
    addressCont.text = appStore.address.validate();

    if (getIntAsync(COUNTRY_ID) != 0) {
      await getCountry();
      await getStates(getIntAsync(COUNTRY_ID));
      if (getIntAsync(STATE_ID) != 0) {
        await getCity(getIntAsync(STATE_ID));
      }

      setState(() {});
    } else {
      await getCountry();
    }
  }

  Future<void> getCountry() async {
    await getCountryList().then((value) async {
      countryList.clear();
      countryList.addAll(value);
      setState(() {});
      value.forEach((e) {
        if (e.id == getIntAsync(COUNTRY_ID)) {
          selectedCountry = e;
        }
      });
    }).catchError((e) {
      toast('$e', print: true);
    });
    appStore.setLoading(false);
  }

  Future<void> getStates(int countryId) async {
    appStore.setLoading(true);
    await getStateList({'country_id': countryId}).then((value) async {
      stateList.clear();
      stateList.addAll(value);
      log(stateList);
      value.forEach((e) {
        if (e.id == getIntAsync(STATE_ID)) {
          selectedState = e;
        }
      });
      setState(() {});
    }).catchError((e) {
      toast('$e', print: true);
    });
    appStore.setLoading(false);
  }

  Future<void> getCity(int stateId) async {
    appStore.setLoading(true);

    await getCityList({'state_id': stateId}).then((value) async {
      cityList.clear();
      cityList.addAll(value);
      value.forEach((e) {
        if (e.id == getIntAsync(CITY_ID)) {
          selectedCity = e;
        }
      });
    }).catchError((e) {
      toast('$e', print: true);
    });
    appStore.setLoading(false);
  }

  Future<void> update() async {
    hideKeyboard(context);

    MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
    multiPartRequest.fields[UserKeys.firstName] = fNameCont.text;
    multiPartRequest.fields[UserKeys.lastName] = lNameCont.text;
    multiPartRequest.fields[UserKeys.userName] = userNameCont.text;
    multiPartRequest.fields[UserKeys.userType] = LoginTypeUser;
    multiPartRequest.fields[UserKeys.contactNumber] = mobileCont.text;
    multiPartRequest.fields[UserKeys.email] = emailCont.text;
    multiPartRequest.fields[UserKeys.countryId] = countryId.toString();
    multiPartRequest.fields[UserKeys.stateId] = stateId.toString();
    multiPartRequest.fields[UserKeys.cityId] = cityId.toString();
    multiPartRequest.fields[CommonKeys.address] = addressCont.text;
    if (imageFile != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath(UserKeys.profileImage, imageFile!.path));
    } else {
      Image.asset(ic_home, fit: BoxFit.cover);
    }

    Map<String, dynamic> req = {
      UserKeys.firstName: userNameCont.text,
      UserKeys.firstName: fNameCont.text,
      UserKeys.uid: getStringAsync(UID),
      UserKeys.lastName: lNameCont.text,
      UserKeys.contactNumber: mobileCont.text,
      UserKeys.email: emailCont.text,
      UserKeys.userType: LoginTypeUser,
      UserKeys.countryId: countryId.toString().toInt(),
      UserKeys.stateId: stateId.toString().toInt(),
      UserKeys.cityId: cityId.toString().toInt(),
      CommonKeys.address: addressCont.text,
      UserKeys.profileImage: appStore.userProfileImage.validate(),
      'updatedAt': Timestamp.now(),
    };

    log('req: $req');

    multiPartRequest.headers.addAll(buildHeaderTokens());
    appStore.setLoading(true);

    userService.updateUserInfo(req, getStringAsync(UID).validate(), profileImage: imageFile != null ? File(imageFile!.path) : null).then((value) {
      sendMultiPartRequest(
        multiPartRequest,
        onSuccess: (data) async {
          appStore.setLoading(false);
          if (data != null) {
            if ((data as String).isJson()) {
              ProfileUpdateResponse res = ProfileUpdateResponse.fromJson(jsonDecode(data));
              log(stateId);
              log(cityId);
              log('token : ${res.data!.api_token}');

              saveUserData(res.data!);
              finish(context);
              snackBar(context, title: res.message!);

              finish(context);
            }
          }
        },
        onError: (error) {
          toast(error.toString(), print: true);
          appStore.setLoading(false);
        },
      ).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(),print: true);
      });
    });
  }

  void _getFromGallery() async {
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      setState(() {});
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: language!.lblGallery,
              leading: Icon(Icons.image, color: primaryColor),
              onTap: () {
                _getFromGallery();
                finish(context);
              },
            ),
            Divider(),
            SettingItemWidget(
              title: language!.camera,
              leading: Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.editProfile, textColor: white, color: context.primaryColor, backWidget: BackWidget()),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      imageFile != null
                          ? Image.file(
                              imageFile!,
                              width: 85,
                              height: 85,
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(40)
                          : Observer(
                              builder: (_) => cachedImage(
                                appStore.userProfileImage,
                                height: 85,
                                width: 85,
                                fit: BoxFit.cover,
                              ).cornerRadiusWithClipRRect(43),
                            ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: boxDecorationWithRoundedCorners(
                            boxShape: BoxShape.circle,
                            backgroundColor: primaryColor,
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(AntDesign.camera, color: Colors.white, size: 12),
                        ).onTap(() async {
                          _showBottomSheet(context);
                        }),
                      ).visible(!isSocialLogin)
                    ],
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: fNameCont,
                    focus: fNameFocus,
                    errorThisFieldRequired: language!.requiredText,
                    nextFocus: lNameFocus,
                    decoration: inputDecoration(context, hint: language!.hintFirstNameTxt),
                    suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: lNameCont,
                    focus: lNameFocus,
                    errorThisFieldRequired: language!.requiredText,
                    nextFocus: userNameFocus,
                    decoration: inputDecoration(context, hint: language!.hintLastNameTxt),
                    suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: userNameCont,
                    focus: userNameFocus,
                    errorThisFieldRequired: language!.requiredText,
                    nextFocus: emailFocus,
                    decoration: inputDecoration(context, hint: language!.hintUserNameTxt),
                    suffix: ic_profile2.iconImage(size: 10).paddingAll(14),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    controller: emailCont,
                    errorThisFieldRequired: language!.requiredText,
                    focus: emailFocus,
                    enabled: !isSocialLogin,
                    nextFocus: mobileFocus,
                    decoration: inputDecoration(context, hint: language!.hintEmailTxt),
                    suffix: ic_message.iconImage(size: 10).paddingAll(14),
                  ),
                  16.height,
                  AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: mobileCont,
                      focus: mobileFocus,
                      errorThisFieldRequired: language!.requiredText,
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
                  16.height,
                  Row(
                    children: [
                      DropdownButtonFormField<CountryListResponse>(
                        decoration: inputDecoration(context, hint: language!.selectCountry),
                        isExpanded: true,
                        value: selectedCountry,
                        dropdownColor: context.cardColor,
                        items: countryList.map((CountryListResponse e) {
                          return DropdownMenuItem<CountryListResponse>(
                            value: e,
                            child: Text(
                              e.name!,
                              style: primaryTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (CountryListResponse? value) async {
                          hideKeyboard(context);
                          countryId = value!.id!;
                          selectedCountry = value;
                          selectedState = null;
                          selectedCity = null;
                          getStates(value.id!);

                          setState(() {});
                        },
                      ).expand(),
                      8.width.visible(stateList.isNotEmpty),
                      if (stateList.isNotEmpty)
                        DropdownButtonFormField<StateListResponse>(
                          decoration: inputDecoration(context, hint: language!.selectState),
                          isExpanded: true,
                          dropdownColor: context.cardColor,
                          value: selectedState,
                          items: stateList.map((StateListResponse e) {
                            return DropdownMenuItem<StateListResponse>(
                              value: e,
                              child: Text(
                                e.name!,
                                style: primaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (StateListResponse? value) async {
                            hideKeyboard(context);
                            selectedCity = null;
                            selectedState = value;
                            stateId = value!.id!;
                            await getCity(value.id!);
                            setState(() {});
                          },
                        ).expand(),
                    ],
                  ),
                  16.height,
                  if (cityList.isNotEmpty)
                    DropdownButtonFormField<CityListResponse>(
                      decoration: inputDecoration(context, hint: language!.selectCity),
                      isExpanded: true,
                      value: selectedCity,
                      dropdownColor: context.cardColor,
                      items: cityList.map((CityListResponse e) {
                        return DropdownMenuItem<CityListResponse>(
                          value: e,
                          child: Text(e.name!, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (CityListResponse? value) async {
                        hideKeyboard(context);
                        selectedCity = value;
                        cityId = value!.id!;
                        setState(() {});
                      },
                    ),
                  16.height,
                  AppTextField(
                    controller: addressCont,
                    textFieldType: TextFieldType.ADDRESS,
                    maxLines: 5,
                    //minLines: 3,
                    decoration: inputDecoration(context, hint: language!.hintAddress),
                    suffix: ic_location.iconImage(size: 10).paddingAll(14),
                  ),
                  40.height,
                  AppButton(
                    text: language!.saveChanges,
                    color: primaryColor,
                    textStyle: primaryTextStyle(color: white),
                    width: context.width() - context.navigationBarHeight,
                    onTap: () {
                      if (getStringAsync(USER_EMAIL) != email) {
                        update();
                      } else {
                        snackBar(context, title: language!.lblUnAuthorized);
                      }
                    },
                  ),
                  24.height,
                ],
              ),
            ),
          ),
          Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
