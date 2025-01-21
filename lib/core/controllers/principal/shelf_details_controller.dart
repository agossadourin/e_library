import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/modules/principal/pages/search_page.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShelfDetailsController extends GetxController {
  static ShelfDetailsController instance = Get.find();
  final RxString query = ''.obs;
  final RxString shelfId = ''.obs;
  final RxList<String> booksIds = <String>[].obs;
  final RxList<Book> filteredBooks = <Book>[].obs;
  final RxList<Book> books = <Book>[].obs;
  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);
  final int pageSize = 10;
  final RxInt currentPage = 0.obs;
  final RxInt totalPages = 0.obs;

  ShelfDetailsController() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize total pages when books are loaded
    currentPage.value = 0;
    ever(booksIds, (_) {
      totalPages.value = (booksIds.length / pageSize).ceil();
    });
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final startIndex = currentPage.value * pageSize;
      final endIndex = startIndex + pageSize;

      final response = await fetchBooksId(startIndex, pageSize);

      if (response.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      final isLastPage =
          endIndex >= booksIds.length || response.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response);
      } else {
        pagingController.appendPage(response, pageKey + pageSize);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<String>> fetchBooksId(int offset, int limit) async {
    try {
      final response = await apiService.getBooksOnShelf(
        shelfId: shelfId.value,
        offset: offset,
        limit: limit,
      );

      return response.fold(
        (exception) => throw exception,
        (books) => books,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<Book> fetchBook(String bookId) async {
    final response = await apiService.getBook(bookId);
    return response.fold(
      (exception) => throw Exception(exception),
      (book) => book,
    );
  }

  Future<void> fetchAllBooks() async {
    principalController.isLoading.value = true;
    books.clear();
    for (String bookId in booksIds) {
      try {
        Book book = await fetchBook(bookId);
        books.add(book);
      } catch (e) {
        // Handle error
        principalController.showSnackBar(
            'oups', ' Quelque chose s\'est mal passé', 1);
      } finally {
        filteredBooks.value = books;
        principalController.isLoading.value = false;
        Get.to(() => SearchPage());
      }
    }
  }

  void filterBooks(String query) {
    if (query.isEmpty) {
      filteredBooks.value = books;
    } else {
      filteredBooks.value = books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value - 1) {
      currentPage.value++;
      pagingController.refresh();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pagingController.refresh();
    }
  }

  void refreshPage() {
    pagingController.refresh();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
