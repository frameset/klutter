import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

class LibraryRepository {
  Future<PageSeriesDto> getSeriesFromLibraries(
      {LibraryDto? library, int? page, List<String>? publishers}) async {
    List<String> libraryList = library == null ? List.empty() : [library.id];
    SeriesController seriesController = await getSeriesController();
    PageSeriesDto pageSeriesDto = await seriesController.getSeries(
      libraryId: libraryList,
      page: page,
      publisher: publishers,
    );
    return pageSeriesDto;
  }
}
