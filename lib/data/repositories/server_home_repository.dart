import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

class ServerHomeRepository {
  Future<List<BookDto>> getKeepReading() async {
    final BookController bookClient = await getBookController();
    final PageBookDto keepReadingBooks = await bookClient.getBooks(
        readStatus: ["IN_PROGRESS"], sort: ["readProgress.lastModified,desc"]);
    if (keepReadingBooks.empty == true) {
      return List.empty();
    } else {
      return keepReadingBooks.content!;
    }
  }

  Future<List<BookDto>> getOndeck() async {
    final BookController bookClient = await getBookController();

    PageBookDto ondeckPage = await bookClient.getOnDeck();
    if (ondeckPage.numberOfElements == 0) {
      return List.empty();
    } else {
      return ondeckPage.content!;
    }
  }

  Future<List<SeriesDto>> getRecentlyaddedSeries() async {
    final SeriesController seriesClient = await getSeriesController();
    final PageSeriesDto recentlyaddedSeries = await seriesClient.getNew();
    if (recentlyaddedSeries.numberOfElements == 0) {
      return List.empty();
    } else {
      return recentlyaddedSeries.content!;
    }
  }

  Future<List<SeriesDto>> getRecentlyupdatedSeries() async {
    final SeriesController seriesClient = await getSeriesController();

    final PageSeriesDto recentlyupdatedSeries = await seriesClient.getUpdated();
    if (recentlyupdatedSeries.empty == true) {
      return List.empty();
    } else {
      return recentlyupdatedSeries.content!;
    }
  }

  Future<List<BookDto>> getRecentlyaddedBooks() async {
    final BookController bookClient = await getBookController();

    final PageBookDto recentlyaddedBooks =
        await bookClient.getBooks(sort: ["createdDate,desc"]);
    if (recentlyaddedBooks.empty == true) {
      return List.empty();
    } else {
      return recentlyaddedBooks.content!;
    }
  }
}
