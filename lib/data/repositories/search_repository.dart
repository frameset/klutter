import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/searchresults.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

class SearchRepository {
  Future<SearchResults> getMixedSearchResults(String query) async {
    return await _getSearchResults(query, 50);
  }

  Future<SearchResults> getSuggestions(String query) async {
    return await _getSearchResults(query, 10);
  }

  Future<SearchResults> _getSearchResults(String query, int size) async {
    late final List<BookDto> bookResults;
    late final List<SeriesDto> seriesResults;
    SeriesController seriesController = await getSeriesController();
    BookController bookController = await getBookController();
    PageBookDto pageBookResults =
        await bookController.getBooks(search: query, size: size);
    PageSeriesDto pageSeriesResults =
        await seriesController.getSeries(search: query, size: size);
    if (pageBookResults.numberOfElements == 0) {
      bookResults = List.empty();
    } else {
      bookResults = pageBookResults.content!;
    }
    if (pageSeriesResults.numberOfElements == 0) {
      seriesResults = List.empty();
    } else {
      seriesResults = pageSeriesResults.content!;
    }
    return SearchResults(bookResults, seriesResults);
  }
}
