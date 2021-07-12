part of 'search_series_thumbnail_cubit.dart';

abstract class SearchSeriesThumbnailState extends Equatable {
  const SearchSeriesThumbnailState();

  @override
  List<Object> get props => [];
}

class SearchSeriesThumbnailInitial extends SearchSeriesThumbnailState {}

class SearchSeriesThumbnailReady extends SearchSeriesThumbnailState {
  final List<int> thumb;
  SearchSeriesThumbnailReady({
    required this.thumb,
  });

  @override
  List<Object> get props => [thumb];
}
