import 'dart:io';

import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/shelf.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_library/core/constants/app_colors.dart';

class PrincipalController extends GetxController {
  static PrincipalController instance = Get.find();
  RxBool isLoading = false.obs;
  RxBool isDarkMode = false.obs;
  RxList<Shelf> shelves = <Shelf>[].obs;

  @override
  void onInit() {
    super.onInit();
    getShelves();
  }

  // snackbars and dialogs

  void showSnackBar(String title, String message, int messageType) {
    Get.showSnackbar(GetSnackBar(
      title: title == "" ? null : title,
      message: message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: messageType == 0
          ? AppColors.successColor
          : messageType == 1
              ? AppColors.warningColor
              : AppColors.errorColor,
      margin: const EdgeInsets.only(
          left: 10, right: 10, bottom: kBottomNavigationBarHeight),
      snackStyle: SnackStyle.GROUNDED,
      mainButton: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () {
          Get.back(); // Close the snackbar
        },
      ),
    ));
  }

  void showCustomDialog(BuildContext context,
      {required String title,
      required String message,
      String onConfirmMessage = 'Confirmer',
      String onBackMessage = 'Annuler',
      required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Annuler'),
                  ),
                  CupertinoDialogAction(
                    onPressed: onConfirm,
                    child: Text(onConfirmMessage),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: onConfirm,
                    child: Text(onConfirmMessage),
                  ),
                ],
              );
      },
    );
  }

  // Method to get shelves
  Future<void> getShelves() async {
    isLoading.value = true;

    try {
      final Either<Exception, List<Shelf>> response =
          await apiService.getShelves();
      if (response.isLeft) {
        logger.d(response.left);
        showSnackBar('Erreur', 'Quelque-chose s\'est mal passé', 2);
      } else {
        shelves.value = response.right;
        for (var shelf in shelves) {
          final bookCountResponse = await apiService.getBookIds(shelf.id);

          if (bookCountResponse.isRight) {
            shelf.bookCount = bookCountResponse.right.length;
            shelf.booksIds = bookCountResponse.right;
          } else {
            logger.e(bookCountResponse.left);
            showSnackBar('oups',
                'Erreur lors de la recuperation du nombre de livres', 1);
          }
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}
