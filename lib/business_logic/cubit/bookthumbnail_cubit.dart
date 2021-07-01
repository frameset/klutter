import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/book_controller.dart';
import 'package:klutter/util/dio_helper.dart';

part 'bookthumbnail_state.dart';

class BookThumbnailCubit extends Cubit<BookThumbnailState> {
  BookThumbnailCubit() : super(BookThumbnailInitial());

  Future<void> getThumbnail(String bookId) async {
    emit(BookThumbnailLoading());
    try {
      BookController bookController = await getBookController();
      final List<int> thumbnail = await bookController.getThumbnail(bookId);
      emit(BookThumbnailReady(thumbnail));
    } on Exception catch (_) {
      emit(BookThumbnailFailed());
    }
  }
}
