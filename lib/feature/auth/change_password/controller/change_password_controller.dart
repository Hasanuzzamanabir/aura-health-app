import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool newPasswordVisibility = true.obs;
  RxBool confirmPasswordVisibility = true.obs;

  void toggleNewPasswordVisibility() {
    newPasswordVisibility.value = !newPasswordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
  }
}
