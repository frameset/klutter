import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/readprogressupdatedto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

class BookScreenRepository {
  // final SeriesController seriesClient = SeriesController(configuredDio());
  // final BookController bookClient = BookController(configuredDio());
  final BookDto book;
  BookScreenRepository(this.book);

  Future<List<int>> getBookThumb() async {
    final BookController bookClient = await getBookController();
    return await bookClient.getThumbnail(book.id);
  }

  Future<SeriesDto> getSeries() async {
    SeriesController seriesClient = await getSeriesController();
    SeriesDto series = await seriesClient.getSeriesById(book.seriesId);
    return series;
  }

  Future<BookDto?> getPreviousBook() async {
    late BookDto prevbook;
    try {
      final BookController bookClient = await getBookController();

      prevbook = await bookClient.getPreviousBook(book.id);
    } on Exception catch (_) {
      return null;
    }
    return prevbook;
  }

  Future<BookDto?> getNextBook() async {
    late BookDto nextbook;
    try {
      final BookController bookClient = await getBookController();

      nextbook = await bookClient.getNextBook(book.id);
    } on Exception catch (_) {
      return null;
    }
    return nextbook;
  }

  Future<List<BookDto>> getBooksInSeries() async {
    SeriesController seriesClient = await getSeriesController();

    PageBookDto seriesBooks =
        await seriesClient.getBooksFromSeries(book.seriesId, unpaged: true);
    if (seriesBooks.numberOfElements == 0) {
      return List.empty();
    } else {
      return seriesBooks.content!;
    }
  }

  Future<void> markAsRead() async {
    final BookController bookClient = await getBookController();

    await bookClient.markAsRead(
        book.id, ReadProgressUpdateDto(completed: true));
  }

  Future<void> markAsUnread() async {
    final BookController bookClient = await getBookController();

    bookClient.deleteReadProgress(book.id);
  }

  Future<void> analyse() async {
    final BookController bookClient = await getBookController();

    bookClient.analyzeBook(book.id);
  }

  Future<void> refreshMetadata() async {
    final BookController bookClient = await getBookController();

    bookClient.refreshMetadata(book.id);
  }
}
