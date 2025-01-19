import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:e_library/core/controllers/principal/principal_controller.dart';
import 'package:e_library/core/controllers/principal/shelf_details_controller.dart';
import 'package:e_library/core/controllers/splash_screen/splash_screen_controller.dart';
import 'package:e_library/modules/principal/pages/shelves_page.dart';
import 'package:e_library/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(SplashScreenController());
  Get.put(PrincipalController());
  Get.put(ShelfDetailsController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          //accentColor: Colors.amber,
        ),
        dark: ThemeData(
          primaryColor: Colors.black12,
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          // accentColor: Colors.amber,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => GetMaterialApp(
              initialRoute: '/',
              getPages: [
                GetPage(name: '/', page: () => SplashScreen()),
                GetPage(
                  name: '/shelves',
                  page: () => ShelvesPage(),
                ),
              ],
            ));
  }
}
