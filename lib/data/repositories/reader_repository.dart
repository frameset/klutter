import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/readprogressupdatedto.dart';

class ReaderRepository {
  final ApiClient apiClient = ApiClient();
  final BookDto book;
  ReaderRepository(this.book);
  Map<int, List<int>> pageMap = Map<int, List<int>>();

  Future<void> cacheAround(int pageNumber) async {
    for (int i = pageNumber - 2; i <= pageNumber + 2; i++) {
      if (i > 0 && i < book.media.pagesCount) {
        //make sure the page isn't going to be out of bounds
        if (!pageMap.containsKey(i)) {
          //if the page isn't already in the cache, go get it
          pageMap[i] = await getPageImage(i);
        }
      }
    }
  }

  Future<List<int>> getPageImage(int pageNumber) async {
    if (pageMap.containsKey(pageNumber)) {
      return pageMap[pageNumber]!;
    } else {
      pageMap[pageNumber] =
          await apiClient.bookController.getPage(book.id, pageNumber);
      return pageMap[pageNumber]!;
    }
  }

  Future<void> updateReadPage(int pageNumber) async {
    await apiClient.bookController
        .markAsRead(book.id, ReadProgressUpdateDto(page: pageNumber));
  }

  Future<BookDto> getNextBook() async {
    return await apiClient.bookController.getNextBook(book.id);
  }

  Future<BookDto> getPrevBook() async {
    return await apiClient.bookController.getPreviousBook(book.id);
  }
}
