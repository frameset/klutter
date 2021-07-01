import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/readprogressupdatedto.dart';
import 'package:klutter/util/dio_helper.dart';

import '../dataproviders/client/book_controller.dart';

class ReaderRepository {
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

  // Future<List<List<int>>> getAllPageImages(BookDto book) async {
  //   BookController _bookClient = await getBookController();
  //   List<PageDto> pages = await _bookClient.getPages(book.id);
  //   return await _getPageImagesFromPageDtos(pages);
  // }

  Future<List<int>> getPageImage(int pageNumber) async {
    BookController _bookClient = await getBookController();

    if (pageMap.containsKey(pageNumber)) {
      return pageMap[pageNumber]!;
    } else {
      pageMap[pageNumber] = await _bookClient.getPage(book.id, pageNumber);
      return pageMap[pageNumber]!;
    }
  }

  Future<void> updateReadPage(int pageNumber) async {
    BookController _bookClient = await getBookController();

    await _bookClient.markAsRead(
        book.id, ReadProgressUpdateDto(page: pageNumber));
  }

  // Future<List<List<int>>> _getPageImagesFromPageDtos(
  //     List<PageDto> pages) async {
  //   return await Future.wait(
  //       pages.map((page) => getPageImage(page.number)).toList());
  // }

  Future<BookDto> getNextBook() async {
    BookController _bookClient = await getBookController();

    return await _bookClient.getNextBook(book.id);
  }

  Future<BookDto> getPrevBook() async {
    BookController _bookClient = await getBookController();

    return await _bookClient.getPreviousBook(book.id);
  }
}
