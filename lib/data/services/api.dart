import 'package:dio/dio.dart';
import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/data/models/book.dart';
import 'package:e_library/data/models/shelf.dart';
import 'package:either_dart/either.dart';

class ApiService {
  static ApiService instance = ApiService();
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.glose.com';
  final String _userId = '5a8411b53ed02c04187ff02a';

  //route to get shelves
  Future<Either<Exception, List<Shelf>>> getShelves(
      {int offset = 0, int limit = 10}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/users/$_userId/shelves',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );
      if (response.statusCode == 200) {
        logger.d(response.data);
        List<Shelf> shelves = (response.data as List)
            .map((shelfJson) => Shelf.fromJson(shelfJson))
            .toList();
        logger.d(shelves);
        return Right(shelves);
      } else {
        logger.d(response);
        return Left(Exception('Failed to load data'));
      }
    } catch (e) {
      return Left(Exception(e));
    }
  }

  // route to get book count on a shelf
  Future<Either<Exception, List<String>>> getBookIds(String shelfId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/shelves/$shelfId/forms',
      );
      if (response.statusCode == 200) {
        logger.d(response.data);
        List<String> bookIds =
            (response.data as List).map((item) => item as String).toList();
        int bookCount = bookIds.length;
        logger.d('bookcount: $bookCount');
        return Right(bookIds);
      } else {
        logger.d(response);
        return Left(Exception('Failed to load data'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  //route to get  book
  Future<Either<Exception, Book>> getBook(String bookId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forms/$bookId',
      );
      if (response.statusCode == 200) {
        Book book = Book.fromJson(response.data);

        return Right(book);
      } else {
        logger.d(response);
        return Left(Exception('Failed to load data'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
