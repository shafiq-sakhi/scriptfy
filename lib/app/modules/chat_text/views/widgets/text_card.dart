import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../constants/constants.dart';
import '../../../../../utils/app_language.dart';

class TextCard extends StatelessWidget {
  TextCard({Key? key, this.textData}) : super(key: key);

  var textData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.pinkLight.withOpacity(0.25)),
            constraints: BoxConstraints(maxWidth: Get.size.width * 0.85),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                textData.text,
                style: TextStyle(
                    fontSize: 15 /*, fontFamily: AppFonts.INTER_REGULAR*/),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              InkWell(
                  onTap: () {
                    Share.share(textData.text);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.blueLight),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.share,
                          size: 18,
                          color: Colors.white,
                        ),
                      ))),
              SizedBox(width: 8),
              InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: textData.text));
                    Get.snackbar(
                      AppLanguage.TEXT_COPIED,
                      '',
                      borderRadius: 10,
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.blueLight),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.copy,
                          size: 18,
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MyTextCard extends StatelessWidget {
  MyTextCard({Key? key, this.textData}) : super(key: key);

  var textData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: Get.size.width * 0.85),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.blueLight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                textData.text,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors
                        .white /*,
                    fontFamily: AppFonts.INTER_REGULAR*/
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
