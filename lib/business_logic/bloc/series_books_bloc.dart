import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/series_books_repository.dart';
// import 'package:rxdart/rxdart.dart';

part 'series_books_event.dart';
part 'series_books_state.dart';

class SeriesBooksBloc extends Bloc<SeriesBooksEvent, SeriesBooksState> {
  SeriesDto series;
  SeriesBooksRepository _repository;
  SeriesBooksBloc(this.series)
      : _repository = SeriesBooksRepository(series),
        super(SeriesBooksInitial());

  // @override
  // Stream<Transition<SeriesBooksEvent, SeriesBooksState>> transformEvents(
  //   Stream<SeriesBooksEvent> events,
  //   TransitionFunction<SeriesBooksEvent, SeriesBooksState> transitionFn,
  // ) {
  //   return super.transformEvents(
  //       events.debounceTime(Duration(milliseconds: 200)), transitionFn);
  // }

  @override
  Stream<SeriesBooksState> mapEventToState(
    SeriesBooksEvent event,
  ) async* {
    if (event is SeriesBooksGetPage) {
      yield SeriesBooksLoading();
      PageBookDto page = await _repository.getPageBook(event.page);
      yield SeriesBooksReady(page);
    }
  }
}
