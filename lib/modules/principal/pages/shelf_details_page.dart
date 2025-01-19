import 'package:e_library/data/models/shelf.dart';
import 'dart:math';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/data/services/api.dart';
import 'package:e_library/core/controllers/principal/shelf_details_controller.dart';
import 'package:e_library/modules/principal/pages/book_details_page.dart';
import 'package:e_library/modules/principal/widgets/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShelfDetailsPage extends StatelessWidget {
  final Shelf shelf;
  final ApiService apiService = ApiService.instance;
  final ShelfDetailsController shelfDetailsController =
      Get.put(ShelfDetailsController());

  ShelfDetailsPage({super.key, required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf.title),
        actions: [
          Obx(() => Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: shelfDetailsController.previousPage,
                  ),
                  Text(
                      '${shelfDetailsController.currentPage.value + 1} / ${(shelfDetailsController.booksIds.length / shelfDetailsController.pageSize).ceil()}'),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: shelfDetailsController.nextPage,
                  ),
                ],
              )),
        ],
      ),
      body: Column(
        children: [
          MySearchBar(),
          Expanded(
            child: Obx(() {
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
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => BookDetailsPage(book: book));
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                        child: book.image.isNotEmpty
                                            ? Image.network(
                                                book.image,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 200,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                      child: Icon(Icons.error));
                                                },
                                              )
                                            : SizedBox(
                                                child: Text(
                                                  book.title,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      book.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
