import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

class SeriesBooksRepository {
  SeriesDto series;

  SeriesBooksRepository(this.series);

  Future<PageBookDto> getPageBook(int pageNumber) async {
    SeriesController seriesController = await getSeriesController();
    PageBookDto pageBook =
        await seriesController.getBooksFromSeries(series.id, page: pageNumber);
    return pageBook;
  }
}
