import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/repositories/server_home_repository.dart';
import 'package:meta/meta.dart';

part 'recentlyaddedbooks_state.dart';

class RecentlyaddedbooksCubit extends Cubit<RecentlyaddedbooksState> {
  final ServerHomeRepository _repository;
  RecentlyaddedbooksCubit(this._repository)
      : super(RecentlyaddedbooksInitial());

  Future<void> getRecentlyaddedBooks() async {
    try {
      emit(RecentlyaddedbooksLoading());
      final List<BookDto> recentlyaddedBooks =
          await _repository.getRecentlyaddedBooks();
      if (recentlyaddedBooks.isEmpty) {
        emit(RecentlyaddedbooksEmpty());
      } else {
        emit(RecentlyaddedbooksLoaded(recentlyaddedBooks));
      }
    } on Exception catch (_) {
      emit(RecentlyaddedbooksError());
    }
  }
}
