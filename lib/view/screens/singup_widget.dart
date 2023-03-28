import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/view/screens/login_widget.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';
import '../../constants/constants.dart';

class SingupWidget extends StatefulWidget {
  SingupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SingupWidget> createState() => _SingupWidgetState();
}

class _SingupWidgetState extends State<SingupWidget> {
  final RoundedLoadingButtonController googleController =
  RoundedLoadingButtonController();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPC = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String imageUrl = '';
  BaseController _baseController = BaseController(Get.context!, () {});
  String code="";
  bool agreeOnTermAndCondition = false;

  //final _accountType = widget.accountType;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPC.dispose();
    super.dispose();
  }

  Future addDetails(String image_url, String name, String phone, String email,
      String uid) async {
    try {
      // validate user input
      var userModel = UserModel.fromJson({
        'PhotoUrl': image_url,
        'Name': name,
        'Phone': (phone.replaceAll(" ", "")),
        'Email': email,
        'UserId': uid,
        "code": number.isoCode,
        "stars": 12
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userModel.toJson(), SetOptions(merge: true));
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      FirebaseAuth.instance.currentUser?.sendEmailVerification();

      Get.snackbar(
        AppLanguage.ACCOUNT_CREATED_SUCCESSFULLY,
        '',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        borderRadius: 10,
      );
      await FirebaseAuth.instance.signOut();
      Get.offAll(LoginWidget());
    } catch (e) {
      _baseController.hideProgress();
      Get.snackbar('${e}', '', borderRadius: 10);
      print(e);
    }
  }

  Future signUp() async {
    try {
      // validate user input
      if (_nameController.text.trim().isEmpty) {
        Get.snackbar(
          AppLanguage.NAME_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      if (_phoneController.text.trim().isEmpty) {
        Get.snackbar(
          AppLanguage.PHONE_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      if (_emailController.text.trim().isEmpty) {
        //throw ('Email field is empty');
        Get.snackbar(
          AppLanguage.EMAIL_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      if (_passwordController.text.trim().isEmpty) {
        //throw ('Password field is empty');
        Get.snackbar(AppLanguage.PASSWORD_IS_EMPTY, '', borderRadius: 10);
        return;
      }
      if (_passwordController.text.trim().length < 8) {
        //throw ('Password must be at least 8 characters');
        Get.snackbar(AppLanguage.PASSWORD_LENGTH, '', borderRadius: 10);
        return;
      }
      if (_passwordController.text.trim() != _confirmPC.text.trim()) {
        //throw ('Passwords do not match');
        Get.snackbar(AppLanguage.PASSWORD_DONOT_MATCHED, '', borderRadius: 10);
        return;
      }
      if(!agreeOnTermAndCondition){
        Get.snackbar(AppLanguage.PLEASE_AGREE_ON_POLICY_AND_USE_TERM, '', borderRadius: 10);
        return;
      }

      _baseController.showProgress();
      // create user
      var currentUser = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      var uid = currentUser.user?.uid ?? "";
      imageUrl = _image == null ? "" : await uploadUserImage(uid, _image?.path ?? "") ?? "";
      // add details to firestore database
      addDetails(imageUrl, _nameController.text.trim(),
          _phoneController.text.trim(), _emailController.text.trim(), uid);
    } on FirebaseException catch (e) {
      _baseController.hideProgress();
      String error = e.message!.substring(5,e.message!.length-1);
      Get.snackbar('${e.message}', '', borderRadius: 10);
      //print(e.message);
    } catch (e) {
      _baseController.hideProgress();

      print(e);
    }
  }

  bool confirmPassword() {
    if (_passwordController.text.trim() == _confirmPC.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  File? _image;

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('users');
  PhoneNumber number = PhoneNumber(isoCode: 'CH');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.backGroundColor,
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
                blur: 15,
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
              SafeArea(
                child: Column(
                  children: [
                    AppBar(
                      leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                      elevation: 0,
                      title: Text(AppLanguage.REGISTER,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: AppFonts.URBANIST_BOLD,
                              color: Colors.white)),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLanguage.GET_STARTED_WITH_SCRIPTFY,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: AppFonts.INTER_REGULAR,
                                            color: Colors.white)),
                                    SizedBox(height: 10),
                                    GlassmorphicContainer(
                                      width: double.infinity,
                                      height: 700,
                                      borderRadius: 20,
                                      blur: 15,
                                      padding: EdgeInsets.all(40),
                                      alignment: Alignment.bottomCenter,
                                      border: 1,
                                      linearGradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.blueDark.withOpacity(0.1),
                                            AppColors.blueDark
                                                .withOpacity(0.05),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 18),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 50),
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: MaterialButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () async {
                                                    showImagePickerOptions();
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: _image == null
                                                          ? Center(
                                                              child: Icon(
                                                              Icons
                                                                  .account_circle_rounded,
                                                              size: 100,
                                                              color: AppColors
                                                                  .pinkLight,
                                                            ))
                                                          : Image.file(
                                                              _image!,
                                                              fit: BoxFit.cover,
                                                            ))),
                                            ),
                                            // const FlutterLogo(
                                            //   size: 120,
                                            // ),
                                            const SizedBox(height: 30),
                                            InputFields(
                                              title: AppLanguage.FULNAME,
                                              hint: AppLanguage.ENTER_YOUR_NAME,
                                              textEditingController:
                                                  _nameController,
                                              titleColor: Colors.white,
                                            ),
                                            const SizedBox(height: 20),

                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                AppLanguage.PHONE_NUMBER,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        AppFonts.INTER_REGULAR,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child:
                                                  InternationalPhoneNumberInput(
                                                onInputChanged: (_number) {
                                                  number = _number;
                                                  // code=number.isoCode??"";
                                                },
                                                initialValue: number,
                                                textFieldController:
                                                    _phoneController,
                                                inputDecoration:
                                                    InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppLanguage
                                                            .ENTER_YOUR_PHONE),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            InputFields(
                                              titleColor: Colors.white,
                                              title: AppLanguage.EMAIL,
                                              hint:
                                                  AppLanguage.ENTER_YOUR_EMAIL,
                                              textEditingController:
                                                  _emailController,
                                            ),
                                            const SizedBox(height: 20),
                                            InputFields(
                                              isPassword: true,
                                              titleColor: Colors.white,
                                              title: AppLanguage.PASSWORD,
                                              hint: AppLanguage
                                                  .ENTER_YOU_PASSWORD,
                                              textEditingController:
                                                  _passwordController,
                                            ),
                                            const SizedBox(height: 20),
                                            InputFields(
                                              isPassword: true,
                                              titleColor: Colors.white,
                                              title:
                                                  AppLanguage.CONFIRM_PASSWORD,
                                              hint: AppLanguage
                                                  .ENTER_OUR_CONFIRM_PASSWORD,
                                              textEditingController: _confirmPC,
                                            ),
                                            SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              if(agreeOnTermAndCondition){
                                                agreeOnTermAndCondition = false;
                                              }else{
                                                agreeOnTermAndCondition = true;
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: AppColors.blueDark,width: 1),
                                                    borderRadius: BorderRadius.circular(5),
                                                    boxShadow: [
                                                      agreeOnTermAndCondition ? BoxShadow(
                                                          color: Colors.black12,
                                                          offset: Offset(0,2),
                                                          blurRadius: 3,
                                                          spreadRadius: 1
                                                      ):BoxShadow(color: Colors.transparent)
                                                    ]
                                                ),
                                                child: Icon(Icons.check,color:agreeOnTermAndCondition ? AppColors.blueDark : AppColors.pinkLight,size: 18,),
                                              ),
                                              SizedBox(width: 15,),
                                              Text(AppLanguage.AGREE_ON_POLICY_AND_USE_TERM,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    AppButton(
                                        title: AppLanguage.REGISTER,
                                        onClick: () {
                                          signUp();
                                        }),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerOptions(){
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Material(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          child: CupertinoActionSheet(
            title: Text(AppLanguage.SELECT_FROM,style: TextStyle(fontSize: 16),),
            cancelButton: CloseButton(
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: (){
                    getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Text(AppLanguage.CAMERA)
              ),
              CupertinoActionSheetAction(
                  onPressed: (){
                    getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Text(AppLanguage.GALLERY)
              ),
            ],
          ),
        )
    );
  }

  Future getImage(ImageSource source) async{
    ImagePicker picker = await ImagePicker();
    XFile? pickedFile = await  picker.pickImage(
      source: source,
    );
    if(pickedFile != null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

}