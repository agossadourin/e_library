import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController instance = Get.find();
  RxDouble opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
    _navigateToShelves();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      opacity.value = 1.0;
    });
  }

  void _navigateToShelves() {
    Future.delayed(Duration(seconds: 4), () {
      Get.offNamed('/shelves');
    });
  }
}
