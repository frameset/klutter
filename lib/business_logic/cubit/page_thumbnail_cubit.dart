import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagedto.dart';
import 'package:klutter/data/repositories/page_repository.dart';

part 'page_thumbnail_state.dart';

class PageThumbnailCubit extends Cubit<PageThumbnailState> {
  final PageRepository _repository;
  final BookDto book;
  PageThumbnailCubit(this.book)
      : _repository = PageRepository(book),
        super(PageThumbnailInitial());

  Future<void> getPageThumbnails() async {
    List<PageDto> pages = await _repository.getPages(book);
    emit(PageThumbnailLoaded(pages));
  }
}
