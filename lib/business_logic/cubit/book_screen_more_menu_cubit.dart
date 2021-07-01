import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/repositories/book_screen_repository.dart';

part 'book_screen_more_menu_state.dart';

class BookScreenMoreMenuCubit extends Cubit<BookScreenMoreMenuState> {
  final BookScreenRepository _repository;
  BookScreenMoreMenuCubit(this._repository)
      : super(BookScreenMoreMenuInitial());

  Future<void> refreshMetadata() async {
    try {
      await _repository.refreshMetadata();
      emit(BookScreenMoreMenuRefreshSuccessful());
    } catch (_) {
      emit(BookScreenMoreMenuRefreshFailed());
    }
  }

  Future<void> analyseMetadata() async {
    try {
      await _repository.refreshMetadata();
      emit(BookScreenMoreMenuAnalysisSuccessful());
    } catch (_) {
      emit(BookScreenMoreMenuAnalysisFailed());
    }
  }

  Future<void> markAsRead() async {
    try {
      await _repository.markAsRead();
      emit(BookScreenMoreMenuMarkReadSuccess());
    } catch (_) {
      emit(BookScreenMoreMenuMarkReadFailed());
    }
  }

  Future<void> markAsUnread() async {
    try {
      await _repository.markAsUnread();
      emit(BookScreenMoreMenuMarkUnreadSuccess());
    } catch (_) {
      emit(BookScreenMoreMenuMarkUnreadFailed());
    }
  }
}
