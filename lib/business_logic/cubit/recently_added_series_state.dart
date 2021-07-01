part of 'recently_added_series_cubit.dart';

@immutable
abstract class RecentlyAddedSeriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentlyAddedSeriesInitial extends RecentlyAddedSeriesState {}

class RecentlyAddedSeriesLoading extends RecentlyAddedSeriesState {}

class RecentlyAddedSeriesLoaded extends RecentlyAddedSeriesState {
  final List<SeriesDto> series;
  RecentlyAddedSeriesLoaded(
    this.series,
  );

  @override
  List<Object> get props => [series];
}

class RecentlyAddedSeriesEmpty extends RecentlyAddedSeriesState {}

class RecentlyAddedSeriesError extends RecentlyAddedSeriesState {}
