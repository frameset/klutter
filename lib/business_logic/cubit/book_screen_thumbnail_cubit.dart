import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/repositories/book_screen_repository.dart';

part 'book_screen_thumbnail_state.dart';

class BookScreenThumbnailCubit extends Cubit<BookScreenThumbnailState> {
  final BookScreenRepository _repository;
  BookScreenThumbnailCubit(this._repository)
      : super(BookScreenThumbnailInitial());

  Future<void> getThumbnail() async {
    try {
      final List<int> thumb = await _repository.getBookThumb();
      emit(BookScreenThumbnailLoaded(thumb));
    } on Exception catch (_) {
      emit(BookScreenThumbnailInitial());
    }
  }
}
