import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/utils/app_language.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  var color;

   SearchTextFieldWidget({
    Key? key,
    this.color,
    this.textEditingController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _searchTextField();
  }

  Widget _searchTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
      constraints: BoxConstraints(maxHeight: Get.size.height*0.30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: AppColors.pinkLight.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Scrollbar(
                                    child: TextField(
                                      style: const TextStyle(fontSize: 14),
                                      controller: textEditingController,
                                      maxLines: null,
                                      decoration:  InputDecoration(
                                          border: InputBorder.none,
                                          hintText:AppLanguage.OPEN_AI_WAITINGFOR_YOUR_QUERY),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                        height: 20,
                        width: 2,
                        color: AppColors.pinkLight.withOpacity(0.17)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: (){
                  onTap?.call();
                  textEditingController!.text="";
                },
                child: Image.asset(
                  "assets/send_message.png",
                  width: 40,
                )),
            const SizedBox(width: 6)
          ],
        ),
      ),
    );
  }
}
