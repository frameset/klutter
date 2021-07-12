import 'package:klutter/data/dataproviders/client/api_client.dart';

class ThumbnailRepository {
  Map<String, List<int>> seriesThumbs = {};
  Map<String, List<int>> bookThumbs = {};
  ApiClient apiClient = ApiClient();

  Future<List<int>> getBookThumb(String id) async {
    if (bookThumbs.containsKey(id)) {
      return bookThumbs[id]!;
    } else {
      bookThumbs[id] = await apiClient.bookController.getThumbnail(id);
      return bookThumbs[id]!;
    }
  }

  Future<List<int>> getSeriesThumb(String id) async {
    if (seriesThumbs.containsKey(id)) {
      return seriesThumbs[id]!;
    } else {
      seriesThumbs[id] = await apiClient.seriesController.getThumbnail(id);
      return seriesThumbs[id]!;
    }
  }
}
