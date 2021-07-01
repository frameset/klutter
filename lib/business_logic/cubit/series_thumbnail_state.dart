part of 'series_thumbnail_cubit.dart';

abstract class SeriesThumbnailState extends Equatable {
  const SeriesThumbnailState();

  @override
  List<Object> get props => [];
}

class SeriesThumbnailInitial extends SeriesThumbnailState {}

class SeriesThumbnailFailed extends SeriesThumbnailState {}

class SeriesThumbnailLoading extends SeriesThumbnailState {}

class SeriesThumbnailReady extends SeriesThumbnailState {
  final List<int> thumbnail;
  const SeriesThumbnailReady(this.thumbnail);

  @override
  List<Object> get props => [thumbnail];
}
