import 'dart:async';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:text_to_image/app/modules/home/views/home_view.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/view/screens/infoPage.dart';
import 'package:text_to_image/view/screens/payment_screen.dart';
import 'package:text_to_image/view/screens/profile.dart';
import 'package:text_to_image/view/screens/splash_screen.dart';
import 'constants/constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  int _selectedIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeView(zoomDrawerController),
      InfoPage(),
      Profile(),
    ];
    attachUserListener();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener;

  void attachUserListener() {
    listener = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        return;
      }
      AdminBaseController.updateUser(UserModel.fromJson(event?.data() ?? {}));
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kPinkGadient,
      child: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: buildMenu(),
        mainScreenScale: 0.1,
        mainScreen:
            Container(decoration: kPinkGadient, child: _pages[_selectedIndex]),
        borderRadius: 40.0,
        showShadow: false,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.white,
        menuScreenWidth: double.infinity,
        slideWidth: MediaQuery.of(context).size.width * 0.54,
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      width: 500,
      decoration: kPinkGadient,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLanguage.MENU,
                  style: TextStyle(
                      fontFamily: AppFonts.POPPINS_BOLD,
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
              Row(
                children: [
                  Image.asset("assets/home.png", width: 60),
                  Text(
                    AppLanguage.HOME,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.INTER_REGULAR,
                        fontSize: 20),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  zoomDrawerController.close?.call();
                  Get.to(InfoPage());
                },
                child: Row(
                  children: [
                    Image.asset("assets/info.png", width: 60),
                    Text(
                      AppLanguage.INFO,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.INTER_REGULAR,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  zoomDrawerController.close?.call();
                  Get.to(() => PaymentScreen());
                },
                child: GetBuilder<AdminBaseController>(
                  builder:(ctr)=>Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.stars,color: Colors.yellow,size: 30),
                      SizedBox(width: 17),
                      Text(
                        AppLanguage.STARS + " (${AdminBaseController.userData.value.stars??""})",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.INTER_REGULAR,
                            fontSize: 20),
                      )
                    ],
                  )
                  ,
                ),
              ),
              SizedBox(height: 2,),
              GestureDetector(
                onTap: ()async {
                  String enPath = '';
                  await fromAsset('assets/pdfs/policy_en.pdf', 'policy_en.pdf').then((f) {
                    setState(() {
                      enPath = f.path;
                    });
                  });
                  String duPath = '';
                  await fromAsset('assets/pdfs/policy_du.pdf', 'policy_du.pdf').then((f) {
                    setState(() {
                      duPath = f.path;
                    });
                  });
                  bool isEnglish = AppLanguage.isEnglish;
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          PDFScreen(path: isEnglish ? enPath : duPath),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 15),
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined,color: AppColors.blueDark,size: 32,),
                      SizedBox(width: 14,),
                      Text(
                        AppLanguage.PRIVACY_POLICY,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.INTER_REGULAR,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2,),
              GestureDetector(
                onTap: ()async {
                  String enPath = '';
                  await fromAsset('assets/pdfs/term_use_en.pdf', 'term_use_en.pdf').then((f) {
                    setState(() {
                      enPath = f.path;
                    });
                  });
                  String duPath = '';
                  await fromAsset('assets/pdfs/term_use_du.pdf', 'term_use_du.pdf').then((f) {
                    setState(() {
                      duPath = f.path;
                    });
                  });
                  bool isEnglish = AppLanguage.isEnglish;
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          PDFScreen(path: isEnglish ? enPath : duPath),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 13),
                  child: Row(
                    children: [
                      Icon(Icons.verified_user,color: AppColors.blueDark,size: 30,),
                      SizedBox(width: 15,),
                      Text(
                        AppLanguage.TERM_OF_USE,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.INTER_REGULAR,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),

              Expanded(child: Container()),
              GestureDetector(
                onTap: () async {
                  var result = await showOkCancelAlertDialog(
                      context: Get.context!,
                      title: AppLanguage.LOGOUT,
                      message: AppLanguage.DO_YOU_REALLY_WANT_TO_LOGOUT,
                      okLabel: AppLanguage.YES,
                      cancelLabel: AppLanguage.NO);
                  if (result == OkCancelResult.cancel) return;
                  FirebaseAuth.instance.signOut();
                  Get.offAll(SplashScreen());
                },
                child: Row(
                  children: [
                    Image.asset("assets/logout.png", width: 60),
                    Text(
                      AppLanguage.LOGOUT,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.INTER_REGULAR,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
            false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}