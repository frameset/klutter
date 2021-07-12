import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/readprogressupdatedto.dart';
import 'package:klutter/data/models/seriesdto.dart';

class BookScreenRepository {
  // final SeriesController seriesClient = SeriesController(configuredDio());
  // final BookController bookClient = BookController(configuredDio());
  final BookDto book;
  BookScreenRepository(this.book);
  ApiClient apiClient = ApiClient();

  Future<List<int>> getBookThumb() async {
    return await apiClient.bookController.getThumbnail(book.id);
  }

  Future<SeriesDto> getSeries() async {
    SeriesDto series =
        await apiClient.seriesController.getSeriesById(book.seriesId);
    return series;
  }

  Future<BookDto?> getPreviousBook() async {
    late BookDto prevbook;
    try {
      prevbook = await apiClient.bookController.getPreviousBook(book.id);
    } on Exception catch (_) {
      return null;
    }
    return prevbook;
  }

  Future<BookDto?> getNextBook() async {
    late BookDto nextbook;
    try {
      nextbook = await apiClient.bookController.getNextBook(book.id);
    } on Exception catch (_) {
      return null;
    }
    return nextbook;
  }

  Future<BookDto> getCurrentBook() async {
    return await apiClient.bookController.getBook(book.id);
  }

  Future<List<BookDto>> getBooksInSeries() async {
    PageBookDto seriesBooks = await apiClient.seriesController
        .getBooksFromSeries(book.seriesId, unpaged: true);
    if (seriesBooks.numberOfElements == 0) {
      return List.empty();
    } else {
      return seriesBooks.content!;
    }
  }

  Future<void> markAsRead() async {
    await apiClient.bookController
        .markAsRead(book.id, ReadProgressUpdateDto(completed: true));
  }

  Future<void> markAsUnread() async {
    apiClient.bookController.deleteReadProgress(book.id);
  }

  Future<void> analyse() async {
    apiClient.bookController.analyzeBook(book.id);
  }

  Future<void> refreshMetadata() async {
    apiClient.bookController.refreshMetadata(book.id);
  }
}
