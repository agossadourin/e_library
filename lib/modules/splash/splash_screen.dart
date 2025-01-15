import 'package:e_library/core/controllers/splash_screen/splash_screen_controller.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenController controller = splashScreenController;

    return Scaffold(
      body: Center(
        child: Obx(() => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: Duration(seconds: 2),
              child: Text(
                'e library',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
