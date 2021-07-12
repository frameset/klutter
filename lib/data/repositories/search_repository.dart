import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/searchresults.dart';
import 'package:klutter/data/models/seriesdto.dart';

class SearchRepository {
  ApiClient apiClient = ApiClient();
  Future<SearchResults> getMixedSearchResults(String query) async {
    return await _getSearchResults(query, 50);
  }

  Future<SearchResults> getSuggestions(String query) async {
    return await _getSearchResults(query, 10);
  }

  Future<SearchResults> _getSearchResults(String query, int size) async {
    late final List<BookDto> bookResults;
    late final List<SeriesDto> seriesResults;
    PageBookDto pageBookResults =
        await apiClient.bookController.getBooks(search: query, size: size);
    PageSeriesDto pageSeriesResults =
        await apiClient.seriesController.getSeries(search: query, size: size);
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

    return SearchResults(
      bookResults: bookResults,
      seriesResults: seriesResults,
    );
  }
}
