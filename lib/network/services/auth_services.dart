import 'package:booking_system_flutter/component/otp_dialog.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/login_model.dart';
import 'package:booking_system_flutter/model/user_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/screens/dashboard/home_screen.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthServices {
  Future<void> updateUserData(UserData user) async {
    userService.updateDocument(
      {
        'player_id': getStringAsync(PLAYERID),
        'updatedAt': Timestamp.now(),
      },
      user.uid,
    );
  }

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user!;

      assert(!user.isAnonymous);

      final User currentUser = _auth.currentUser!;
      assert(user.uid == currentUser.uid);
      signOutGoogle();

      String firstName = '';
      String lastName = '';

      if (currentUser.displayName.validate().split(' ').length >= 1) firstName = currentUser.displayName.splitBefore(' ');
      if (currentUser.displayName.validate().split(' ').length >= 2) lastName = currentUser.displayName.splitAfter(' ');

      await setValue(LOGIN_TYPE, LoginTypeGoogle);
      await appStore.setUserProfile(currentUser.photoURL!);

      Map req = {
        "email": currentUser.email,
        "first_name": firstName,
        "last_name": lastName,
        "username": currentUser.displayName,
        "profile_image": currentUser.photoURL,
        "accessToken": googleSignInAuthentication.accessToken,
        "login_type": LoginTypeGoogle,
        "user_type": LoginTypeUser,
      };

      return await loginUser(req, isSocialLogin: true).then((value) async {
        await loginFromFirebaseUser(currentUser, loginDetail: value, fName: firstName, lName: lastName);
        appStore.setToken(value.data!.api_token.validate());
        return currentUser;
      }).catchError((e) {
        throw e;
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<void> loginWithOTP(BuildContext context, String phoneNumber) async {
    return await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        //
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          toast('The provided phone number is not valid.');
          throw 'The provided phone number is not valid.';
        } else {
          toast(e.toString());
          throw e.toString();
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        finish(context);
        await showInDialog(
          context,
          builder: (context) => OTPDialog(verificationId: verificationId, isCodeSent: true, phoneNumber: phoneNumber),
          barrierDismissible: false,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //
      },
    );
  }

  Future<void> signUpWithEmailPassword(context, {String? name, String? email, String? password, String? mobileNumber, String? lName, String? userName, bool? isOTP}) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!).catchError((e) {
      log("Err ${e.toString()}");
    });

    if (userCredential.user != null) {
      User currentUser = userCredential.user!;

      UserData userModel = UserData();
      var displayName = name! + lName!;

      /// Create user
      userModel.uid = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.contact_number = mobileNumber;
      userModel.first_name = name;
      userModel.last_name = lName;
      userModel.username = userName;
      userModel.display_name = displayName;
      userModel.user_type = LoginTypeUser;
      userModel.loginType = getStringAsync(LOGIN_TYPE);
      userModel.created_at = Timestamp.now().toDate().toString();
      userModel.updated_at = Timestamp.now().toDate().toString();
      userModel.player_id = getStringAsync(PLAYERID);

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        var request = {
          UserKeys.firstName: name,
          UserKeys.lastName: lName,
          UserKeys.userName: userName,
          UserKeys.userType: LoginTypeUser,
          UserKeys.contactNumber: mobileNumber,
          UserKeys.email: email,
          UserKeys.password: password,
          UserKeys.uid: userModel.uid,
          UserKeys.loginType: getStringAsync(LOGIN_TYPE)
        };

        await createUser(request).then((res) async {
          await loginUser(request).then((res) async {
            toast(language!.loginSuccessfully, print: true);
            if (res.data != null) saveUserData(res.data!);

            HomeScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
          }).catchError((e) {
            toast(e.toString());
          });
        }).catchError((e) {
          toast(e.toString());
          return;
        });
        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signIn(context, {String? email, String? password, LoginResponse? res}) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
    if (userCredential.user != null) {
      User currentUser = userCredential.user!;

      UserData userModel = UserData();

      /// Create user
      userModel.uid = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.contact_number = res!.data!.contact_number;
      userModel.first_name = res.data!.first_name;
      userModel.last_name = res.data!.last_name;
      userModel.username = res.data!.username;
      userModel.display_name = res.data!.display_name;
      userModel.country_id = res.data!.country_id;
      userModel.address = res.data!.address;
      userModel.city_id = res.data!.city_id;
      userModel.state_id = res.data!.state_id;
      userModel.user_type = LoginTypeUser;
      userModel.created_at = Timestamp.now().toDate().toString();
      userModel.updated_at = Timestamp.now().toDate().toString();
      userModel.player_id = getStringAsync(PLAYERID);

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        appStore.setUId(currentUser.uid);

        await signInWithEmailPassword(context, email: email, password: password).then((value) {
          //
        });
      });
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> signInWithEmailPassword(context, {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      appStore.setLoading(true);
      final User user = value.user!;
      UserData userModel = await userService.getUser(email: user.email);
      await updateUserData(userModel);

      appStore.setLoading(true);
      setValue(USER_EMAIL, userModel.email.validate());
      setValue(IS_LOGGED_IN, true);

      //Login Details to AppStore
      appStore.setUserEmail(userModel.email.validate());
      appStore.setUId(userModel.uid.validate());
      //
    }).catchError((e) {
      log(e.toString());
    });
  }

  Future<void> loginFromFirebaseUser(
    User currentUser, {
    LoginResponse? loginDetail,
    String? fullName,
    String? fName,
    String? lName,
  }) async {
    UserData userModel = UserData();

    if (await userService.isUserExist(loginDetail!.data!.email)) {
      ///Return user data
      await userService.userByEmail(loginDetail.data!.email).then((user) async {
        userModel = user;
        saveUserData(userModel);

        await updateUserData(user);
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      /// Create user
      log('Not Exist');
      userModel.uid = currentUser.uid.validate();
      userModel.id = loginDetail.data!.id.validate();
      userModel.email = loginDetail.data!.email.validate();
      userModel.first_name = loginDetail.data!.first_name.validate();
      userModel.last_name = loginDetail.data!.last_name.validate();
      userModel.contact_number = loginDetail.data!.contact_number.validate();
      userModel.display_name = loginDetail.data!.display_name.validate();
      userModel.username = loginDetail.data!.display_name.validate();
      userModel.email = loginDetail.data!.email.validate();
      userModel.user_type = LoginTypeUser;
      userModel.api_token = loginDetail.data!.api_token.validate();

      if (isIos) {
        userModel.display_name = fullName;
      } else {
        userModel.display_name = loginDetail.data!.display_name.validate();
      }

      userModel.contact_number = loginDetail.data!.contact_number.validate();
      userModel.profile_image = loginDetail.data!.profile_image.validate();
      userModel.player_id = getStringAsync(PLAYERID);

      appStore.setLoggedIn(true);
      saveUserData(userModel);

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) {
        //
      }).catchError((e) {
        throw e;
      });
    }
  }

  Future<void> signUpWithOTP(
    context, {
    String? name,
    String? email,
    String? password,
    String? mobileNumber,
    String? lName,
    String? userName,
    String? verificationId,
    String? otpCode,
  }) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId.validate(),
      smsCode: otpCode.validate(),
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((result) async {
      if (result.user != null) {
        User currentUser = result.user!;

        UserData userModel = UserData();
        var displayName = name! + lName!;

        /// Create user
        userModel.uid = currentUser.uid;
        userModel.email = currentUser.email;
        userModel.contact_number = mobileNumber;
        userModel.first_name = name;
        userModel.last_name = lName;
        userModel.username = userName;
        userModel.display_name = displayName;
        userModel.user_type = LoginTypeUser;
        userModel.loginType = getStringAsync(LOGIN_TYPE);
        userModel.created_at = Timestamp.now().toDate().toString();
        userModel.updated_at = Timestamp.now().toDate().toString();
        userModel.player_id = getStringAsync(PLAYERID);

        await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
          var request = {
            UserKeys.firstName: name,
            UserKeys.lastName: lName,
            UserKeys.userName: userName,
            UserKeys.userType: LoginTypeUser,
            UserKeys.contactNumber: mobileNumber,
            UserKeys.email: email,
            UserKeys.password: password,
            UserKeys.uid: userModel.uid,
            UserKeys.loginType: getStringAsync(LOGIN_TYPE)
          };
          await createUser(request).then((res) async {
            await loginUser(request).then((res) async {
              HomeScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
            }).catchError((e) {
              toast(e.toString());
            });
          }).catchError((e) {
            toast(e.toString());
            return;
          });
          appStore.setLoading(false);
        }).catchError((e) {
          appStore.setLoading(false);
          toast(e.toString());
        });
      } else {
        throw errorSomethingWentWrong;
      }
    });
  }
}
