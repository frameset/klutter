part of 'recentlyupdatedseries_cubit.dart';

abstract class RecentlyUpdatedSeriesState extends Equatable {
  const RecentlyUpdatedSeriesState();

  @override
  List<Object> get props => [];
}

class RecentlyUpdatedSeriesInitial extends RecentlyUpdatedSeriesState {}

class RecentlyUpdatedSeriesLoading extends RecentlyUpdatedSeriesState {}

class RecentlyUpdatedSeriesEmpty extends RecentlyUpdatedSeriesState {}

class RecentlyUpdatedSeriesLoaded extends RecentlyUpdatedSeriesState {
  final List<SeriesDto> series;
  RecentlyUpdatedSeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}

class RecentlyUpdatesSeriesError extends RecentlyUpdatedSeriesState {}
