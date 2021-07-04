import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagedto.dart';
import 'package:klutter/data/repositories/page_repository.dart';

part 'page_thumbnail_state.dart';

class PageThumbnailCubit extends Cubit<PageThumbnailState> {
  PageRepository _repository;
  BookDto book;
  Map<int, List<int>> thumbMap = {};
  int mapSize = 0;
  PageThumbnailCubit(this.book)
      : _repository = PageRepository(book),
        super(PageThumbnailInitial());

  Future<void> getPageThumbnails() async {
    List<PageDto> pages = await _repository.getPages(book);
    emit(PageThumbnailLoaded(pages, thumbMap, mapSize));

    for (PageDto page in pages) {
      if (!thumbMap.containsKey(page.number)) {
        List<int> thumb = await _repository.getPageThumbnail(page);
        mapSize++;
        thumbMap[page.number] = thumb;

        emit(PageThumbnailLoaded(pages, thumbMap, mapSize));
      }
    }
  }

  // @override
  // void onChange(Change<PageThumbnailState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  //   print(change);
  // }
}
