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
    BookDto? previousBook;
    BookDto? nextBook;
    SeriesDto series = await _repository.getSeries();
    previousBook = await _repository.getPreviousBook();

    nextBook = await _repository.getNextBook();
    List<BookDto> booksInSeries = await _repository.getBooksInSeries();
    List<int> thumb = await _repository.getBookThumb();
    emit(BookscreenInfoReady(
        booksInSeries: booksInSeries,
        series: series,
        thumb: thumb,
        nextBook: nextBook,
        previousBook: previousBook));
  }
}
