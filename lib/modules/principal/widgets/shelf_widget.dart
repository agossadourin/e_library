import 'dart:math';

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
    return GestureDetector(
      onTap: () {
        Get.to(ShelfDetailsPage(shelf: shelf));
      },
      child: Card(
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
                color: color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  shelf.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
    );
  }
}
