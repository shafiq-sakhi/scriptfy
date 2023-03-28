import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rive/rive.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/utils/data_cache.dart';
import 'package:text_to_image/utils/global_functions.dart';
import 'package:text_to_image/view/screens/payment_screen.dart';
import 'package:text_to_image/view/screens/splash_screen.dart';
import 'package:text_to_image/view/screens/update_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/add_helper.dart';
import 'full_image_view_screen.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text(
            AppLanguage.INFO,
            style: TextStyle(
                fontFamily: AppFonts.POPPINS_SEMI_BOLD, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<AdminBaseController>(
            builder: (_) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  AdminBaseController.userData?.value?.photoUrl != "" ? AppCacheImage(
                    onTap: (){
                      Get.to(MediaPreview(medias:AdminBaseController.userData.value.photoUrl ?? ""));

                    },
                    imageUrl:
                        AdminBaseController.userData?.value?.photoUrl ?? "",
                    width: 100,
                    height: 100,
                    round: 50,
                  ): Container(width: 100 ,height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    border: Border.all(color: AppColors.blueDark,width: 1)
                  ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AdminBaseController.userData?.value?.name ?? "",
                    style: TextStyle(fontFamily: AppFonts.POPPINS_BOLD),
                  ),
                  SizedBox(height: 15),
                  OptionItem(
                    title: AppLanguage.ACCOUNT,
                    items: [
                      {
                        "icon": Icons.email_outlined,
                        "title":
                            AdminBaseController?.userData.value.email ?? "",
                      },
                      {
                        "icon": Icons.phone,
                        "title":
                            AdminBaseController?.userData.value.phone ?? "",
                      },
                      {
                        "icon": Icons.account_circle,
                        "title": AppLanguage.UPDATE_PROFILE,
                        "callBack": () {
                          Get.to(UpdateProfile());
                        }
                      },
                      {
                        "icon": Icons.delete,
                        "title": AppLanguage.DELETE_ACCOUNT,
                        "callBack": () {
                          deleteUser();
                        }
                      },
                      {
                        "icon": Icons.star,
                        "title": AppLanguage.PURCHASE_STAR +
                            " (${AdminBaseController.userData.value.stars ?? 0})",
                        "callBack": () {
                          Get.to(PaymentScreen());
                        }
                      }
                    ],
                  ),
                  OptionItem(title: AppLanguage.REVIEWS, items: [
                    {
                      "icon": Icons.star_border,
                      "title": AppLanguage.GOTO_REVIEWS,
                      "callBack": () async {
                        final InAppReview inAppReview = InAppReview.instance;

                        await inAppReview.openStoreListing(
                            appStoreId: Platform.isAndroid
                                ? "com.fantechlabs.everlove1"
                                : "1642469291");
                      }
                    }
                  ]),
                  // OptionItem(title: AppLanguage.LANGUAGE, items: [
                  //   {
                  //     "icon": Icons.language,
                  //     "title": AppLanguage.UPDATE_LANGUAGE,
                  //     "callBack": () async {
                  //       var isEnglish = DataCache.isEnglish();
                  //       var result = await showConfirmationDialog(
                  //           context: Get.context!,
                  //           title: AppLanguage.UPDATE_LANGUAGE,
                  //           message: AppLanguage.SELECT_LANGUAGE,
                  //           actions: [
                  //             AlertDialogAction(
                  //                 isDefaultAction: isEnglish,
                  //                 label: AppLanguage.ENGLISH,
                  //                 key: "0"),
                  //             AlertDialogAction(
                  //                 isDefaultAction: !isEnglish,
                  //                 label: AppLanguage.GERMAN,
                  //                 key: "1"),
                  //           ]);
                  //       if (result == null) return;
                  //       print(result);
                  //       if (result == "0")
                  //         DataCache.setLanguage(true);
                  //       else
                  //         DataCache.setLanguage(false);
                  //       Get.offAll(SplashScreen());
                  //     }
                  //   }
                  // ]),
                  OptionItem(title: AppLanguage.SUPPORT, items: [
                    {
                      "icon": Icons.info_outline,
                      "title": AppLanguage.SUPPORT,
                      "callBack": () async{
                        String email = Uri.encodeComponent("aemis.gmbh@gmail.com");
                        String subject = Uri.encodeComponent("Hello Scriptfy");
                        String body = Uri.encodeComponent("Hi! I'm Scriptfy user");
                        print(subject); //output: Hello%20Flutter
                        Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                        if (await launchUrl(mail)) {
                        //email app opened
                        }else{
                          showAlert(context, "Can't open mail!");
                        }
                      }
                    }
                  ]),
                  SizedBox(height: 30),
                  BannerCustomWidget(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
  //
  // Future<void> _launchUrl(String url) async {
  //   if (!await launchUrl(Uri.parse(url))) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  BaseController _baseController = BaseController(Get.context!, () {});

  void deleteUser() async {
    try {
      var result = await showOkCancelAlertDialog(
          context: Get.context!,
          title: AppLanguage.DELETE_ACCOUNT,
          message: AppLanguage.DO_YOU_REALLY_WANT_TO_DELETE);
      if (result == OkCancelResult.cancel) return;
      _baseController.hideProgress();
      var text = await showTextInputDialog(
          context: Get.context!,
          message: AppLanguage.ENTER_YOUR_PASSWORD_BEFORE_DELETING_ACCOUNT,
          textFields: [DialogTextField(hintText: "******")]);
      if (text == null || text.isEmpty || text[0] == null || text[0].isEmpty)
        return;
      _baseController.showProgress();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AdminBaseController.userData.value.email ?? "",
          password: text[0]);
      await FirebaseAuth.instance.currentUser?.delete();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(AdminBaseController.userData.value?.userId ?? "")
          .delete();
      await deleteFile(AdminBaseController.userData?.value?.photoUrl ?? "");

      _baseController.hideProgress();
      await FirebaseAuth.instance.signOut();
      await showOkAlertDialog(context: Get.context!, title: "Account deleted");

      Get.offAll(SplashScreen());
    } on Exception catch (e) {
      _baseController.hideProgress();
      showOkAlertDialog(
          context: Get.context!,
          title: AppLanguage.ERROR,
          message: e.toString());
    }
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 30,
          // color: Colors.grey.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: AppFonts.POPPINS_BOLD),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ...items.map((e) {
                    return GestureDetector(
                      onTap: e["callBack"],
                      child: SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            Icon(e["icon"]),
                            SizedBox(width: 12),
                            Expanded(
                                child: Text(
                              e["title"],
                              style: TextStyle(
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  fontSize: 17),
                            )),
                            SizedBox(width: 20),
                            if (e["callBack"] != null) Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
