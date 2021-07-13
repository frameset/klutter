import 'dart:async';
// import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/library_repository.dart';

part 'library_view_event.dart';
part 'library_view_state.dart';

class LibraryViewBloc extends Bloc<LibraryViewEvent, LibraryViewState> {
  LibraryDto? library;
  LibraryRepository _repository = LibraryRepository();
  LibraryViewBloc({this.library}) : super(LibraryViewInitial());

  // @override
  // Stream<Transition<LibraryViewEvent, LibraryViewState>> transformEvents(
  //   Stream<LibraryViewEvent> events,
  //   TransitionFunction<LibraryViewEvent, LibraryViewState> transitionFn,
  // ) {
  //   return super.transformEvents(
  //       events.debounceTime(Duration(milliseconds: 200)), transitionFn);
  // }

  @override
  Stream<LibraryViewState> mapEventToState(
    LibraryViewEvent event,
  ) async* {
    if (event is LibraryViewLoad) {
      PageSeriesDto seriesPage = await _repository.getSeriesFromLibraries(
          page: event.page, library: library);
      yield LibraryViewLoaded(seriesPage);
    }
  }
}
