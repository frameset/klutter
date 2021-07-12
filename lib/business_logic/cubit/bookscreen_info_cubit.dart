import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/book_screen_repository.dart';

part 'bookscreen_info_state.dart';

class BookscreenInfoCubit extends Cubit<BookscreenInfoState> {
  final BookScreenRepository _repository;
  BookscreenInfoCubit(this._repository) : super(BookscreenInfoInitial());

  Future<void> getInfo() async {
    SeriesDto series = await _repository.getSeries();
    List<int> thumb = await _repository.getBookThumb();
    BookDto currentbook = await _repository.getCurrentBook();

    emit(
      BookscreenInfoReady(
          // booksInSeries: booksInSeries,
          series: series,
          thumb: thumb,
          currentbook: currentbook),
    );
  }
}
