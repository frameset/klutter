import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagedto.dart';
import 'package:klutter/util/dio_helper.dart';

class PageRepository {
  BookDto book;
  PageRepository(this.book);

  Future<List<PageDto>> getPages(BookDto book) async {
    BookController bookController = await getBookController();
    return await bookController.getPages(book.id);
  }

  Future<List<int>> getPageThumbnail(PageDto page) async {
    BookController bookController = await getBookController();
    return await bookController.getPageThumbnail(book.id, page.number);
  }
}
