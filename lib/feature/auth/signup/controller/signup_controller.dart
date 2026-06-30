import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {
  RxBool passwordVisibility = true.obs;
  RxBool confirmPasswordVisibility = true.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
  }
}
