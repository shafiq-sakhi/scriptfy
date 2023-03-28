import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/view/screens/code_completion.dart';
import 'package:text_to_image/utils/add_helper.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/app_language.dart';
import '../../../../constants/constants.dart';
import '../../../../view/screens/full_image_view_screen.dart';
import '../../../../view/screens/home.dart';
import '../../../routes/app_pages.dart';

class HomeView extends StatefulWidget {
  HomeView(this.zoomDrawerController, {Key? key}) : super(key: key);

  ZoomDrawerController? zoomDrawerController;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isShow = false;

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userName = '';
    // File _image;
    FirebaseFirestore.instance.collection('users');
    final _user = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: GetBuilder<AdminBaseController>(
          builder:(_)=> SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if(isShow) {
                              widget.zoomDrawerController?.close?.call();
                            } else {
                            widget.zoomDrawerController?.open?.call();
                            }
                            isShow = !isShow;
                          },
                          child: SvgPicture.asset("assets/svg/menu.svg")),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                            '${AppLanguage.HI} ${AdminBaseController.userData.value.name ?? ""}  👋',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontFamily: AppFonts.POPPINS_BOLD,
                                fontWeight: FontWeight.bold)),
                      ),
                      AdminBaseController.userData.value.photoUrl != "" ? AppCacheImage(
                        imageUrl: AdminBaseController.userData.value.photoUrl ?? "",
                        width: 35,
                        height: 35,
                        round: 17.5,
                        onTap: (){
                          Get.to(MediaPreview(medias:AdminBaseController.userData.value.photoUrl ?? ""));
                        },
                      ):Container(width: 35 ,height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            border: Border.all(color: AppColors.blueDark,width: 1)
                        ),)
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(AppLanguage.WHAT_YOU_WANT_TO_DO,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppFonts.POPPINS_BOLD,
                          fontSize: 24)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DashBoardItem(
                          title: AppLanguage.CODE_COMPLETION,
                          icon: "d1",
                          color1: Color(0xFFFFAC71),
                          color2: Color(0xFFFF8450),
                          onclick: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (_)=> CodeCompletion(isStory: false,)));
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: DashBoardItem(
                          title: AppLanguage.IMAGE_GENERATION,
                          icon: "d3",
                          color1: Color(0xFF02AAB0),
                          color2: Color(0xFF00CDAC),
                          onclick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeArtify()));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: DashBoardItem(
                          title: AppLanguage.TEXT_COMPLETION,
                          icon: "d2",
                          color1: Color(0xFF605780),
                          color2: Color(0xFF909AB8),
                          onclick: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (_)=> CodeCompletion(isStory: true,)));
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: DashBoardItem(
                          title: AppLanguage.EMBEDDING,
                          icon: "d4",
                          color1: Color(0xFF000000),
                          color2: Color(0xFF636363),
                          onclick: () {
                            Get.snackbar(
                              AppLanguage.COMMING_SOON,
                              "",
                              borderRadius: 10,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BannerCustomWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeCard(var image, var text, var color, var callback) {
    return InkWell(
      onTap: callback,
      child: Card(
        color: color,
        child: Center(
          child: SizedBox(
            height: 180,
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  image,
                  color: Colors.white,
                  size: 44,
                ),
                const SizedBox(height: 12),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashBoardItem extends StatelessWidget {
  const DashBoardItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.onclick,
  });

  final String icon;
  final String title;
  final Color color1;
  final Color color2;
  final Function() onclick;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color1, color2]),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: Get.size.width * 0.5,
      child: MaterialButton(
        onPressed: onclick,
        minWidth: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/${icon}.png",
                  height: Get.size.width * 0.23,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: AppFonts.POPPINS_BOLD),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
