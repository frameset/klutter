part of 'series_info_cubit.dart';

abstract class SeriesInfoState extends Equatable {
  const SeriesInfoState();

  @override
  List<Object> get props => [];
}

class SeriesInfoLoading extends SeriesInfoState {}

class SeriesInfoReady extends SeriesInfoState {
  final SeriesDto series;
  SeriesInfoReady(this.series);
  @override
  List<Object> get props => [series.id];
}

class SeriesInfoFailed extends SeriesInfoState {}
