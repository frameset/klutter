part of 'series_books_bloc.dart';

abstract class SeriesBooksEvent extends Equatable {
  const SeriesBooksEvent();

  @override
  List<Object> get props => [];
}

class SeriesBooksGetPage extends SeriesBooksEvent {
  final int page;
  SeriesBooksGetPage(this.page);

  @override
  List<Object> get props => [page];
}
