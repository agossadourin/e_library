import 'dart:math';

import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/shelf.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/data/services/api.dart';
import 'package:e_library/core/controllers/principal/shelf_details_controller.dart';
import 'package:e_library/modules/principal/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelfDetailsPage extends StatelessWidget {
  final Shelf shelf;
  final ApiService apiService = ApiService.instance;
  final ShelfDetailsController shelfDetailsController =
      Get.put(ShelfDetailsController());

  ShelfDetailsPage({super.key, required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: principalController.isDarkMode.value
          ? AppColors.backgroundColorDark
          : AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: false,
          backgroundColor: principalController.isDarkMode.value
              ? AppColors.backgroundColorDark3
              : AppColors.backgroundColor,
          title: Text(
            shelf.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Page: '),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 15,
                              ),
                              onPressed: shelfDetailsController.previousPage,
                            ),
                            Text(
                                '${shelfDetailsController.currentPage.value + 1} / ${(shelfDetailsController.booksIds.length / shelfDetailsController.pageSize).ceil()}'),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 15,
                              ),
                              onPressed: shelfDetailsController.nextPage,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => principalController.isLoading.value
                        ? CircularProgressIndicator()
                        : Card(
                            child: IconButton(
                                onPressed: () async {
                                  logger.d('going to search page');
                                  await shelfDetailsController
                                      .fetchAllBooks(); // Fetch all books when the page is loaded
                                },
                                icon: Icon(Icons.search)),
                          ))
                  ],
                )),
          ),
        ),
      )

      /*AppBar(
        title: Text(shelf.title),
        actions: [],
      )*/
      ,
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              logger.d(
                  'page current: ${shelfDetailsController.currentPage.value}');
              final pageStart = shelfDetailsController.currentPage.value *
                  shelfDetailsController.pageSize;
              final pageEnd = pageStart + shelfDetailsController.pageSize;
              final currentPageItems = shelfDetailsController.booksIds.sublist(
                pageStart,
                pageEnd < shelfDetailsController.booksIds.length
                    ? pageEnd
                    : shelfDetailsController.booksIds.length,
              );

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 270,
                ),
                itemCount: currentPageItems.length,
                itemBuilder: (context, index) {
                  final bookId = currentPageItems[index];
                  return FutureBuilder<Book>(
                    future: shelfDetailsController.fetchBook(bookId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('OUPS!!: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('Aucun livre'));
                      }

                      final book = snapshot.data!;
                      return Obx(() {
                        if (book.title.toLowerCase().contains(
                            shelfDetailsController.query.value.toLowerCase())) {
                          return BookWidget(book: book);
                        } else {
                          return SizedBox.shrink();
                        }
                      });
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
