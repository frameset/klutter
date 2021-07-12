part of 'series_list_cubit.dart';

abstract class SeriesListState extends Equatable {
  const SeriesListState();

  @override
  List<Object> get props => [];
}

class SeriesListInitial extends SeriesListState {}

class SeriesListLoading extends SeriesListState {}

class SeriesListEmpty extends SeriesListState {}

class SeriesListReady extends SeriesListState {
  final PageSeriesDto seriesPage;
  SeriesListReady(this.seriesPage);

  @override
  List<Object> get props => [seriesPage];
}
