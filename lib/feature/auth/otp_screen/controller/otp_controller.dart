import 'dart:async';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final seconds = 119.obs;
  Timer? _timer;
  final otpCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    seconds.value = 119;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  String get timer =>
      "${seconds.value ~/ 60}:${(seconds.value % 60).toString().padLeft(2, '0')}";

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
