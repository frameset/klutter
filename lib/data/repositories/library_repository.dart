import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';

class LibraryRepository {
  ApiClient apiClient = ApiClient();
  Future<PageSeriesDto> getSeriesFromLibraries(
      {LibraryDto? library, int? page, List<String>? publishers}) async {
    List<String> libraryList = library == null ? List.empty() : [library.id];
    PageSeriesDto pageSeriesDto = await apiClient.seriesController.getSeries(
      libraryId: libraryList,
      page: page,
      publisher: publishers,
    );
    return pageSeriesDto;
  }
}
