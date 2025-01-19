import 'dart:math';

import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/shelf.dart';

import 'package:e_library/data/models/book.dart';
import 'package:e_library/data/services/api.dart';
import 'package:e_library/core/controllers/principal/shelf_details_controller.dart';
import 'package:e_library/modules/principal/pages/book_details_page.dart';
import 'package:e_library/modules/principal/widgets/my_search_bar.dart';
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
    final random = Random();
    final color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: false,
          backgroundColor: color,
          title: Text(
            shelf.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
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
                    Card(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                    )
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
