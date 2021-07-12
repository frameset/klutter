part of 'series_books_bloc.dart';

abstract class SeriesBooksState extends Equatable {
  const SeriesBooksState();

  @override
  List<Object> get props => [];
}

class SeriesBooksInitial extends SeriesBooksState {}

class SeriesBooksReady extends SeriesBooksState {
  final PageBookDto page;
  SeriesBooksReady(this.page);

  @override
  List<Object> get props => [page];
}

class SeriesBooksLoading extends SeriesBooksState {}
