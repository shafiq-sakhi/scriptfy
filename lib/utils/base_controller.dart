import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_image/utils/app_language.dart';

//**************************************************
class BaseController //**************************************************
{
  final BuildContext? _context;
  BuildContext? _dialogContext;
  Function? onStateChange;
  static bool isAlreadyShow = false;
  bool isBackNavigation = false;

  //**************************************************
  BaseController(this._context, this.onStateChange);

  //**************************************************

  //**************************************************
  void dismissKeyBoard()
  //**************************************************
  {
    // FocusScope.of(_context).requestFocus(FocusNode());
  }

  //**************************************************
  void showProgress()
  //**************************************************
  {
    if (isAlreadyShow) {
      return;
    }
    isAlreadyShow = true;
    showDialog(
        context: _context!,
        barrierDismissible: false,
        builder: (_context) {
          _dialogContext = _context;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                titlePadding: const EdgeInsets.symmetric(vertical: 15),
                insetPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NativeProgress(isBackNav: isBackNavigation,),
                      SizedBox(width: 20),
                      Text(AppLanguage.LOADING)
                    ],
                  ),
                )),
          );
        });
  }

  //**************************************************
  void hideProgress()
  //**************************************************
  {
    try {
      if (BaseController.isAlreadyShow) {
        BaseController.isAlreadyShow = false;
        Navigator.pop(Get.context!);
        isBackNavigation = true;
      }
      //if (_dialogContext != null) Navigator.pop(_dialogContext!);
    } catch (E) {}
  }
}

class NativeProgress extends StatelessWidget {
  final bool isBackNav;
  const NativeProgress({Key? key, required this.isBackNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Platform.isAndroid
            ? const Center(
            child: SizedBox(
                height: 30, width: 30, child: CircularProgressIndicator()))
            : Center(
          child: Theme(
              data: ThemeData(
                  cupertinoOverrideTheme: const CupertinoThemeData(
                      brightness: Brightness.light,
                      primaryColor: Colors.white,
                      barBackgroundColor: Colors.white)),
              child: const CupertinoActivityIndicator()),
        ),
        onWillPop: ()async => isBackNav
    );
  }
}

//******************************************************************************
Future<String?> uploadUserImage(String uid, String path) async {
//******************************************************************************

  try {
    return await uploadImage("users/" + uid + "/profile", path);
  } on Exception catch (e) {
    return null;
  }
}

//******************************************************************************
Future<String> uploadImage(String uid, String path) async {
//*****************************************************************************
  Reference reference = FirebaseStorage.instance.ref().child(uid);
  UploadTask uploadTask = reference.putFile(File(path));
  TaskSnapshot snapshot = await uploadTask;
  var url = await snapshot.ref.getDownloadURL();
  print(url);
  return url;
}

Future deleteFile(String url) async {
  if ((url?.isEmpty ?? true) || !url.contains("firebasestorage")) {
    return;
  }

  try {
    Reference photoRef = FirebaseStorage.instance.refFromURL(url);
    print(photoRef.fullPath);
    if (photoRef.isBlank == false) await photoRef.delete();
  } on Exception catch (e) {
// TODO
  }
}
