import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/modules/principal/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: principalController.isDarkMode.value
          ? AppColors.backgroundColorDark
          : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: principalController.isDarkMode.value
            ? AppColors.backgroundColorDark3
            : AppColors.backgroundColor,
        title: Text(
          'Rechercher un livre',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: principalController.isDarkMode.value
                ? AppColors.title1ColorDark
                : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: principalController.isDarkMode.value
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(
                color: principalController.isDarkMode.value
                    ? AppColors.title1ColorDark
                    : Colors.black,
              ),
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                shelfDetailsController.filterBooks(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (shelfDetailsController.books.isEmpty) {
                return Center(child: Text('No books found'));
              }
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: List.generate(
                    shelfDetailsController.filteredBooks.length, (index) {
                  final book = shelfDetailsController.filteredBooks[index];
                  return BookWidget(book: book);
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
