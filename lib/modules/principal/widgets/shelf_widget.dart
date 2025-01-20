import 'dart:math';
import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/shelf.dart';
import 'package:e_library/modules/principal/pages/shelf_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelfWidget extends StatelessWidget {
  final Shelf shelf;

  const ShelfWidget({super.key, required this.shelf});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () {
            shelfDetailsController.pagingController.refresh();
            shelfDetailsController.currentPage.value = 0;
            shelfDetailsController.booksIds.value = shelf.booksIds;
            shelfDetailsController.shelfId.value = shelf.id;
            Get.to(ShelfDetailsPage(shelf: shelf));
          },
          child: Obx(
            () => Card(
              color: principalController.isDarkMode.value
                  ? AppColors.backgroundColorDark2
                  : AppColors.backgroundColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: principalController.isDarkMode.value
                          ? AppColors.backgroundColorDark3
                          : color,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        shelf.title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.title1ColorDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Auteur: ${shelf.user.name}',
                      style: TextStyle(
                        color: principalController.isDarkMode.value
                            ? AppColors.title2ColorDark
                            : AppColors.title2Color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Nombre de livres: ${shelf.bookCount}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
