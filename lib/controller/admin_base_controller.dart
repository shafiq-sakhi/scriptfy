//*******************************************************************
import 'package:get/get.dart';

import '../models/user_model.dart';

class AdminBaseController
    extends GetxController //*******************************************************************
{
  var userModel = UserModel().obs;

  //*******************************************************************

  //*******************************************************************

  //*******************************************************************
  static void updateUser(UserModel userModel) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController(), permanent: true);
    userController.userModel.value = userModel;
    userController.update();
  }

  static Rx<UserModel> get userData {
    return Get.put(AdminBaseController(), permanent: true).userModel;
  }
}
