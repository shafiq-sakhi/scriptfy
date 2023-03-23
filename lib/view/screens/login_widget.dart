import 'dart:developer';
import 'dart:ui';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/home_page.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/utils/global_functions.dart';
import 'package:text_to_image/view/screens/singup_widget.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';
import '../../utils/app_language.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final RoundedLoadingButtonController googleController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController = RoundedLoadingButtonController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BaseController _baseController = BaseController(Get.context!, () {});
  PhoneNumber number = PhoneNumber(isoCode: 'CH');

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future addDetails(String image_url, String name, String phone, String email,
      String uid,bool isGoogle) async {
    log('add details called');
    try {
      // validate user input
      var userModel = UserModel.fromJson({
        'PhotoUrl': image_url,
        'Name': name,
        'Phone': (phone.replaceAll(" ", "")),
        'Email': email,
        'UserId': uid,
        // "code": number.isoCode,
        "stars": 12
      });

      if(await checkUserExists(uid)){
        log('id exist --------');
        var user = await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .get();
        AdminBaseController.updateUser(
            UserModel.fromJson(user.data() ?? {}));
        _baseController.hideProgress();
        Get.snackbar(
          AppLanguage.WELCOME_TO_SCRIPTFY,
          '',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          borderRadius: 10,
        );
      }else{
        log('id not exist --------');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(userModel.toJson(), SetOptions(merge: true));
        AdminBaseController.updateUser(userModel);
        Get.snackbar(
          AppLanguage.ACCOUNT_CREATED_SUCCESSFULLY,
          '',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          borderRadius: 10,
        );
      }
      if(isGoogle) {
        googleController.success();
      }else{
        facebookController.success();
      }
      Get.offAll(() => MyHomePage());
    } catch (e) {

      Get.snackbar('$e', '', borderRadius: 10);
      log(e.toString());
    }
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists(uid) async {
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snap.exists) {
      log("EXISTING USER");
      return true;
    } else {
      log("NEW USER");
      return false;
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null){
      // Obtain the auth details from the request
      try {
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth?.accessToken,
                idToken: googleAuth?.idToken,
              );
        // Once signed in, return the UserCredential
        User userDetails = (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
        await addDetails(userDetails.photoURL!, userDetails.displayName!, "", userDetails.email!, userDetails.uid! , true);
      }on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            showAlert(context, "You already have an account with us. Use correct provider");
            break;

          case "null":
            showAlert(context, "Some unexpected error while trying to sign in");
            break;
          default:
            print(e.toString());
        }
      }
    }else{
      showAlert(context, "Failed");
      facebookController.reset();
    }

  }

  // sign in with facebook
  Future signInWithFacebook() async {
    final FacebookAuth facebookAuth = FacebookAuth.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final LoginResult result = await facebookAuth.login(
      permissions: [
        'public_profile'
      ],
      loginBehavior: LoginBehavior.webOnly,
    );
    if (result.status == LoginStatus.success) {
      log("Result : $result");

      try {
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await firebaseAuth.signInWithCredential(credential);
        final userData = await FacebookAuth.instance.getUserData();
        log("userdata is: $userData");
        String email = userCredential.user!.email ?? "";

        await addDetails(userCredential.user!.photoURL!, userCredential.user!.displayName!, "",email,
            userCredential.user!.uid,false);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            showAlert(context, "You already have an account with us. Use correct provider");
            break;

          case "null":
            showAlert(context, "Some unexpected error while trying to sign in");
            break;
          default:
            print(e.toString());
        }
      }
    } else {
      showAlert(context, "Failed");
      facebookController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.pinkLight,
        body: Container(
          decoration: kPinkGadient,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Opacity(
                    opacity: 0.15,
                    child: SvgPicture.asset(
                      "assets/svg/fan.svg",
                      fit: BoxFit.fitWidth,
                      width: Get.width,
                    )),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Opacity(
                    opacity: 0.15,
                    child: SvgPicture.asset(
                      "assets/svg/fan.svg",
                      fit: BoxFit.fitWidth,
                      width: Get.width,
                    )),
              ),

              GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 8,
                alignment: Alignment.bottomCenter,
                border: 0,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.2),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.5),
                    Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 70),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/icon.png',
                            fit: BoxFit.fitWidth,
                            width: Get.size.width * 0.40,
                          ),
                        ),
                        Text(AppLanguage.HI_WELCOME_BACK,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: AppFonts.URBANIST_BOLD,
                                color: Colors.white)),
                        Text(AppLanguage.HELO_AGAIN_YOU_HAVE_BEEN_MISSED,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFonts.INTER_REGULAR,
                                color: Colors.white)),
                        SizedBox(height: 20),
                        GlassmorphicContainer(
                          width: double.infinity,
                          height: 238,
                          borderRadius: 20,
                          blur: 20,
                          padding: EdgeInsets.all(40),
                          alignment: Alignment.bottomCenter,
                          border: 1,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.blueDark.withOpacity(0.1),
                                AppColors.blueDark.withOpacity(0.05),
                              ],
                              stops: [
                                0.1,
                                1,
                              ]),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.blueDark.withOpacity(0.5),
                              AppColors.blueDark.withOpacity(0.5),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
                            child: Column(
                              children: [
                                InputFields(
                                  titleColor: Colors.white,
                                  title: AppLanguage.EMAIL,
                                  hint: AppLanguage.ENTER_YOUR_EMAIL,
                                  textEditingController: _emailController,
                                ),
                                SizedBox(height: 30),
                                InputFields(
                                  title: AppLanguage.PASSWORD,
                                  hint: AppLanguage.ENTER_YOU_PASSWORD,
                                  isPassword: true,
                                  titleColor: Colors.white,
                                  textEditingController: _passwordController,
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        AppButton(
                          title: AppLanguage.SIGNIN,
                          onClick: () async {
                            try {
                              if (_emailController.text.trim().isEmpty) {
                                //throw ('Email field is empty');
                                Get.snackbar(
                                  AppLanguage.EMAIL_IS_EMPTY,
                                  '',
                                  borderRadius: 10,
                                );
                                return;
                              }
                              // if (!EmailValidator.validate(_emailController.text.trim())) {
                              //   throw ('Invalid email address');
                              // }
                              if (_passwordController.text.trim().isEmpty) {
                                //throw ('Password field is empty');
                                Get.snackbar(AppLanguage.PASSWORD_IS_EMPTY, '',
                                    borderRadius: 10);
                                return;
                              }
                              if (_passwordController.text.trim().length < 8) {
                                //throw ('Password must be at least 8 characters');
                                Get.snackbar(AppLanguage.PASSWORD_LENGTH, '',
                                    borderRadius: 10);
                                return;
                              }
                              _baseController.showProgress();

                              final newUser = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());

                              if (!(newUser.user?.emailVerified ?? false)) {
                                await newUser.user?.sendEmailVerification();
                                _baseController.hideProgress();
                                await FirebaseAuth.instance.signOut();
                                showOkAlertDialog(
                                    context: Get.context!,
                                    title: AppLanguage.ERROR,
                                    message: AppLanguage
                                        .VERIICATION_EMAIL_SENT_PLEASE_VERIFY_EMAIL);
                                _baseController.hideProgress();
                                return;
                              }
                              var user = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(newUser.user?.uid ?? "")
                                  .get();
                              AdminBaseController.updateUser(
                                  UserModel.fromJson(user.data() ?? {}));
                              _baseController.hideProgress();

                              Get.offAll(() => MyHomePage());
                            } catch (e) {
                              _baseController.hideProgress();
                              showOkAlertDialog(
                                  context: Get.context!,
                                  title: AppLanguage.ERROR,
                                  message: AppLanguage.THE_EMAIL_OR_PASSWORD_IS_WRONG);
                              print(e);
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLanguage.ALREAD_HAVE_ACCOUNT,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Get.to(SingupWidget());
                              },
                              child: Text(
                                AppLanguage.REGISTER,
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontFamily: AppFonts.URBANIST_BOLD,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        RoundedLoadingButton(
                          onPressed: () async{
                            await signInWithGoogle();
                          },
                          controller: googleController,
                          successColor: Colors.lightBlue,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          color: Colors.red,
                          child: Wrap(
                            children:  [
                              Icon(
                                FontAwesomeIcons.google,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(AppLanguage.CONTINUE_WITH_GOOGLE,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RoundedLoadingButton(
                          onPressed: () async{
                            await signInWithFacebook();
                          },
                          controller: facebookController,
                          successColor: Colors.blue,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          color: Colors.blue,
                          child: Wrap(
                            children:  [
                              Icon(
                                FontAwesomeIcons.facebook,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(AppLanguage.SIGN_IN_WITH_FACEBOOK,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class InputFields extends StatefulWidget {
  const InputFields({
    super.key,
    required this.title,
    required this.hint,
    required this.textEditingController,
    this.isPassword = false,
    this.titleColor = Colors.black,
  });

  final String title;
  final String hint;
  final bool isPassword;
  final TextEditingController textEditingController;
  final Color titleColor;

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: widget.titleColor,
                fontFamily: AppFonts.INTER_REGULAR,
                fontSize: 14),
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: widget.textEditingController,
                obscureText: widget.isPassword && _passwordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,
                  suffixIcon: !widget.isPassword
                      ? null
                      : IconButton(
                          color: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
