import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagedto.dart';

class PageRepository {
  ApiClient apiClient = ApiClient();
  BookDto book;
  PageRepository(this.book);

  Future<List<PageDto>> getPages(BookDto book) async {
    return await apiClient.bookController.getPages(book.id);
  }

  Future<List<int>> getPageThumbnail(PageDto page) async {
    return await apiClient.bookController
        .getPageThumbnail(book.id, page.number);
  }
}
