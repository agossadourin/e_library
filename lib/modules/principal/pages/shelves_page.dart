import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/modules/principal/widgets/shelf_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelvesPage extends StatelessWidget {
  const ShelvesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: principalController.isDarkMode.value
              ? AppColors.backgroundColorDark
              : AppColors.backgroundColor,
          appBar: AppBar(
            title: Text(
              'Liste des étagères',
              style: TextStyle(
                color: principalController.isDarkMode.value
                    ? AppColors.title1ColorDark
                    : AppColors.title1Color,
              ),
            ),
            backgroundColor: principalController.isDarkMode.value
                ? AppColors.backgroundColorDark
                : AppColors.backgroundColor,
            elevation: 1,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.brightness_6,
                  color: !principalController.isDarkMode.value
                      ? AppColors.backgroundColorDark
                      : AppColors.backgroundColor,
                ),
                onPressed: () {
                  principalController.isDarkMode.value =
                      !principalController.isDarkMode.value;
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => principalController.getShelves(),
            child: Obx(() {
              if (principalController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (principalController.shelves.isEmpty) {
                return Center(
                  child: Text('Empty list'),
                );
              } else {
                return ListView.builder(
                  itemCount: principalController.shelves.length,
                  itemBuilder: (context, index) {
                    return ShelfWidget(
                        shelf: principalController.shelves[index]);
                  },
                );
              }
            }),
          ),
        ));
  }
}
