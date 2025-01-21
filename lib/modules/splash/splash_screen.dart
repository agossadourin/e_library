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
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Obx(() => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: Duration(seconds: 2),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'e',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Change the color of 'e'
                      ),
                    ),
                    TextSpan(
                      text: ' library',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
