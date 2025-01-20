import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:flutter/material.dart';
import 'package:e_library/data/models/book.dart';

import 'package:get/get.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: principalController.isDarkMode.value
          ? AppColors.backgroundColorDark
          : AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          book.title,
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
        backgroundColor: principalController.isDarkMode.value
            ? AppColors.backgroundColorDark3
            : AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  book.image,
                  height: size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Auteurs:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: principalController.isDarkMode.value
                        ? Colors.white
                        : Colors.black),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: book.authors
                    .map((author) => Text(
                          author.name,
                          style: TextStyle(
                              color: principalController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.black),
                        ))
                    .toList(),
              ),
              SizedBox(height: 8),
              SizedBox(height: 8),
              Text(
                'Titre court: ${book.shortTitle}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Langue: ${book.language}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                book.description,
                style: TextStyle(
                  fontSize: 16,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ISBN: ${book.isbn}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Publié par: ${book.publisher}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tags:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: principalController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: book.tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: principalController.isDarkMode.value
                              ? AppColors.backgroundColorDark2
                              : AppColors.backgroundColor,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
