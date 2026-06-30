import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool passwordVisibility = true.obs;

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }
}
