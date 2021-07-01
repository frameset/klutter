part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQuery extends SearchEvent {
  final String query;
  SearchQuery(
    this.query,
  );

  @override
  List<Object> get props => [query];
}

class SearchSuggestQuery extends SearchEvent {
  final String query;
  SearchSuggestQuery(
    this.query,
  );
  @override
  List<Object> get props => [query];
}

class SearchMore extends SearchEvent {}
