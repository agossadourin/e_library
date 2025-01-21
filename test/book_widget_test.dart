import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/modules/principal/widgets/book_widget.dart';
import 'package:e_library/core/controllers/principal/principal_controller.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BookWidget', () {
    setUp(() {
      // Initialize the PrincipalController
      Get.put(PrincipalController());
    });

    testWidgets('Displays book details and handles image loading',
        (WidgetTester tester) async {
      final book = Book(
        form: '..',
        extents: Extents(glPages: 3),
        bookDetails: BookDetails(id: 'offf', slug: 'slug'),
        id: '1',
        title: 'Flutter for Beginners',
        shortTitle: 'Flutter',
        language: 'English',
        description: '<p>This is a beginner book for Flutter.</p>',
        isbn: '1234567890',
        publisher: 'Publisher 1',
        authors: [Author(id: '0', name: 'Author 1', slug: 'slug')],
        tags: ['flutter', 'beginner'],
        image: '', // Use empty string to trigger local asset image
      );

      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: BookWidget(book: book),
          ),
        ),
      );

      // Wait for all animations and frames to complete
      await tester.pumpAndSettle();

      // Verify the presence of the book title
      expect(find.text('Flutter for Beginners'), findsNWidgets(2));
    });
  });
}
