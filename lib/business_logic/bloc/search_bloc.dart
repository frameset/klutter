import 'dart:async';

import 'package:klutter/data/models/searchresults.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/repositories/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _repository = SearchRepository();
  int page = 0;
  SearchBloc() : super(SearchInitial());

  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 200)), transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchQuery) {
      yield SearchLoading();
      SearchResults searchResults =
          await _repository.getMixedSearchResults(event.query);
      yield SearchReady(searchResults);
    }
    if (event is SearchSuggestQuery) {
      yield SearchLoading();
      SearchResults searchResults =
          await _repository.getSuggestions(event.query);
      yield SearchSuggestionsReady(searchResults);
    }
  }
}
