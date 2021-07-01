part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchReady extends SearchState {
  final SearchResults searchResults;
  SearchReady(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class SearchSuggestionsReady extends SearchState {
  final SearchResults searchResults;
  SearchSuggestionsReady(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class SearchError extends SearchState {}
