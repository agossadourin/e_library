import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/modules/principal/pages/book_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BookDetailsPage(book: book)),
      child: Card(
        color: principalController.isDarkMode.value
            ? AppColors.backgroundColorDark2
            : AppColors.backgroundColor,
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: book.image.isNotEmpty
                      ? Image.network(
                          book.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer(
                              duration: Duration(seconds: 2), //Default value
                              color: Colors.white, //Default value
                              enabled: true, //Default value
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                color: !principalController.isDarkMode.value
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        )
                      : SizedBox(
                          child: Text(
                            book.title,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: principalController.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black),
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
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
