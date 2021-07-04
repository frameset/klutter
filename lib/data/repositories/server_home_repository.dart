import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/seriesdto.dart';

class ServerHomeRepository {
  ApiClient apiClient = ApiClient();
  Future<List<BookDto>> getKeepReading() async {
    final PageBookDto keepReadingBooks = await apiClient.bookController
        .getBooks(
            readStatus: ["IN_PROGRESS"],
            sort: ["readProgress.lastModified,desc"]);
    if (keepReadingBooks.empty == true) {
      return List.empty();
    } else {
      return keepReadingBooks.content!;
    }
  }

  Future<List<BookDto>> getOndeck() async {
    PageBookDto ondeckPage = await apiClient.bookController.getOnDeck();
    if (ondeckPage.numberOfElements == 0) {
      return List.empty();
    } else {
      return ondeckPage.content!;
    }
  }

  Future<List<SeriesDto>> getRecentlyaddedSeries() async {
    final PageSeriesDto recentlyaddedSeries =
        await apiClient.seriesController.getNew();
    if (recentlyaddedSeries.numberOfElements == 0) {
      return List.empty();
    } else {
      return recentlyaddedSeries.content!;
    }
  }

  Future<List<SeriesDto>> getRecentlyupdatedSeries() async {
    final PageSeriesDto recentlyupdatedSeries =
        await apiClient.seriesController.getUpdated();
    if (recentlyupdatedSeries.empty == true) {
      return List.empty();
    } else {
      return recentlyupdatedSeries.content!;
    }
  }

  Future<List<BookDto>> getRecentlyaddedBooks() async {
    final PageBookDto recentlyaddedBooks =
        await apiClient.bookController.getBooks(sort: ["createdDate,desc"]);
    if (recentlyaddedBooks.empty == true) {
      return List.empty();
    } else {
      return recentlyaddedBooks.content!;
    }
  }
}
