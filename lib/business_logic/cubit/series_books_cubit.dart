import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/series_books_repository.dart';

part 'series_books_state.dart';

class SeriesBooksCubit extends Cubit<SeriesBooksState> {
  SeriesDto series;
  SeriesBooksRepository _repository;
  SeriesBooksCubit(this.series)
      : _repository = SeriesBooksRepository(series),
        super(SeriesBooksInitial());

  Future<void> getBookPage(int pageNumber) async {
    print("getting page $pageNumber");
    PageBookDto page = await _repository.getPageBook(pageNumber);
    emit(SeriesBooksReady(page));
  }
}
