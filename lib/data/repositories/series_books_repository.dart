import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';

class SeriesBooksRepository {
  ApiClient apiClient = ApiClient();
  SeriesDto series;

  SeriesBooksRepository(this.series);

  Future<PageBookDto> getPageBook(int pageNumber) async {
    PageBookDto pageBook = await apiClient.seriesController
        .getBooksFromSeries(series.id, page: pageNumber, size: 50);
    return pageBook;
  }
}
