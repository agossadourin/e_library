import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/modules/principal/pages/book_details_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BookDetailsPage', () {
    testWidgets('Displays book details', (WidgetTester tester) async {
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
        image: 'https://example.com/flutter.jpg',
      );

      await tester.pumpWidget(
        GetMaterialApp(
          home: BookDetailsPage(book: book),
        ),
      );

      // Wait for all animations and frames to complete
      await tester.pumpAndSettle();

      expect(find.text('Flutter for Beginners'), findsOneWidget);
      expect(find.text('Short Title: Flutter'), findsOneWidget);
      expect(find.text('Language: English'), findsOneWidget);
      expect(find.text('ISBN: 1234567890'), findsOneWidget);
      expect(find.text('Publisher: Publisher 1'), findsOneWidget);
      expect(find.text('Author 1'), findsOneWidget);
      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('beginner'), findsOneWidget);
    });
  });
}
