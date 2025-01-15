import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/book.dart';
import 'package:get/get.dart';

class ShelfDetailsController extends GetxController {
  static ShelfDetailsController instance = Get.find();
  final RxString query = ''.obs;

  Future<Book> fetchBook(String bookId) async {
    final response = await apiService.getBook(bookId);
    return response.fold(
      (exception) {
        throw Exception(exception);
      },
      (book) => book,
    );
  }
}
