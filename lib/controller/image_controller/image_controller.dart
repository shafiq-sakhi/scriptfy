import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_image/utils/PermissionUtils.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';

import '../../models/image_model/image_model.dart';
import '../../utils/add_helper.dart';

class ImageController extends GetxController {
  var url = Uri.parse('https://api.openai.com/v1/images/generations');
  var api_token = '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';
  int numImages = 4;

  Rx<ImageModel> image = ImageModel().obs;

  final data = ''.obs;
  String result = '';
  final isLoading = false.obs;
  BaseController _baseController = BaseController(Get.context!, () {});

  Future getImage({required String imageText}) async {
    try {
      isLoading.value = true;
      _baseController.showProgress();
      _loadInterstitialAd();

      var request = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api_token',
        },
        body: jsonEncode(
          {
            'prompt': imageText,
            'num_images': numImages,
          },
        ),
      );

      _baseController.hideProgress();
      if (request.statusCode == 200) {
        isLoading.value = false;
        data.value = jsonDecode(request.body)['data'][0]['url'];
        image.value = ImageModel.fromJson((jsonDecode(request.body)));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
            .set({"stars": FieldValue.increment(-4)}, SetOptions(merge: true));
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      _baseController.hideProgress();
      isLoading.value = false;
    }
  }

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
            },
          );

          ad.show();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
  downloadImage(BuildContext context, String url) async {
    if (!(await PermissionUtils(
            permission: Permission.storage,
            permissionName: AppLanguage.STORAGE,
            context: Get.context!)
        .isAllowed)) return;
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        showOkAlertDialog(
            context: Get.context!,
            message: AppLanguage.DOWNLOADING);
        await ImageDownloader.downloadImage(
          url,
          destination: AndroidDestinationType.custom(
            directory: 'Download',
          ),
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  downloadAllImages(BuildContext context, String url) async {
    if((image?.value?.data ?? []).isEmpty)
      return;

    var result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: AppLanguage.DOWNLOAD_IMAGE,
        message: AppLanguage.YOU_REALLYWANT_TO_DOWNLOAD_ALL_IMAGES,
        okLabel: AppLanguage.YES,
        cancelLabel: AppLanguage.NO);
    if (result == OkCancelResult.cancel) return;
    if (!(await PermissionUtils(
            permission: Permission.storage,
            permissionName: AppLanguage.STORAGE,
            context: Get.context!)
        .isAllowed)) return;
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        showOkAlertDialog(
            context: Get.context!,
            message: AppLanguage.DOWNLOADING);
        for (var image in (image?.value?.data ?? [])) {
          await ImageDownloader.downloadImage(
            image?.url ?? "",
            destination: AndroidDestinationType.custom(
              directory: 'Download',
            ),
          );
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }
}