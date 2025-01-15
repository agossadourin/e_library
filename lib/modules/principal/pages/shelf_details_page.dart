import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/data/models/shelf.dart';
import 'package:e_library/modules/principal/widgets/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelfDetailsPage extends StatelessWidget {
  final Shelf shelf;

  const ShelfDetailsPage({super.key, required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf.title),
      ),
      body: Column(
        children: [
          MySearchBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 270),
              itemCount: shelf.booksIds.length,
              itemBuilder: (context, index) {
                final bookId = shelf.booksIds[index];
                return FutureBuilder<Book>(
                  future: shelfDetailsController.fetchBook(bookId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('OUPS!!:'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('Aucun livre'));
                    } else {
                      final book = snapshot.data!;
                      return Obx(() {
                        if (book.title.toLowerCase().contains(
                            shelfDetailsController.query.value.toLowerCase())) {
                          return Card(
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
                                              book.image, // Assuming book has an imageUrl field
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: 200,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Icon(Icons.error));
                                              },
                                            )
                                          : SizedBox(
                                              child: Text(
                                                book.title,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
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
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
