import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_image/app/modules/chat_text/views/widgets/text_card.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/utils/app_language.dart';
import '../../../../controller/admin_base_controller.dart';
import '../../../../utils/app_cache_image.dart';
import '../../../../view/screens/full_image_view_screen.dart';
import '../../../common/headers.dart';
import '../../../common/search_text_field_widget.dart';
import '../controllers/chat_text_controller.dart';

class ChatTextView extends GetView<ChatTextController> {
  const ChatTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pinkLight,
        title: Row(
          children: [
            AppCacheImage(
              imageUrl: AdminBaseController.userData.value.photoUrl ?? "",
              width: 40,
              height: 40,
              round: 20,
              onTap: (){
                Get.to(MediaPreview(medias:AdminBaseController.userData.value.photoUrl ?? ""));
              },
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  controller.isStory ? AppLanguage.TEXT_COMPLETION : AppLanguage.CHAT_GPT,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: AppFonts.POPPINS_SEMI_BOLD),
                ),
                Text(
                  AppLanguage.ONLINE,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Obx(() => Column(children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final textData = controller.messages[index];
                        return textData.index == -999999
                            ? MyTextCard(textData: textData)
                            : TextCard(textData: textData);
                      },
                    ),
                  ),
                  controller.state.value == ApiState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                  const SizedBox(height: 12),
                  SearchTextFieldWidget(
                      color: Colors.green.withOpacity(0.8),
                      textEditingController: controller.searchTextController,
                      onTap: () {
                        controller.getTextCompletion(
                            controller.searchTextController.text);
                      }),
                  const SizedBox(height: 20),
                ])),
          ),
        ),
      ),
    );
  }
}
