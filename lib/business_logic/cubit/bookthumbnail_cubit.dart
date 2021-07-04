import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';

part 'bookthumbnail_state.dart';

class BookThumbnailCubit extends Cubit<BookThumbnailState> {
  ApiClient apiClient = ApiClient();
  BookThumbnailCubit() : super(BookThumbnailInitial());

  Future<void> getThumbnail(String bookId) async {
    emit(BookThumbnailLoading());
    try {
      final List<int> thumbnail =
          await apiClient.bookController.getThumbnail(bookId);
      emit(BookThumbnailReady(thumbnail));
    } on Exception catch (_) {
      emit(BookThumbnailFailed());
    }
  }
}
