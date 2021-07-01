part of 'library_view_bloc.dart';

abstract class LibraryViewState extends Equatable {
  const LibraryViewState();

  @override
  List<Object> get props => [];
}

class LibraryViewInitial extends LibraryViewState {}

class LibraryViewLoadMore extends LibraryViewState {}

class LibraryViewLoading extends LibraryViewState {
  final List<SeriesDto> series;
  LibraryViewLoading(this.series);
  @override
  List<Object> get props => [series];
}

class LibraryViewLoaded extends LibraryViewState {
  final List<SeriesDto> series;
  final bool? end;
  LibraryViewLoaded(this.series, {this.end});

  @override
  List<Object> get props => [series];
}
