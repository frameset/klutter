part of 'bookscreen_info_cubit.dart';

abstract class BookscreenInfoState extends Equatable {
  const BookscreenInfoState();

  @override
  List<Object?> get props => [];
}

class BookscreenInfoInitial extends BookscreenInfoState {}

class BookscreenInfoReady extends BookscreenInfoState {
  final SeriesDto series;
  final BookDto currentbook;
  final BookDto? nextBook;
  final BookDto? previousBook;
  final List<BookDto>? booksInSeries;
  final List<int> thumb;
  BookscreenInfoReady(
      {required this.series,
      required this.currentbook,
      this.nextBook,
      this.previousBook,
      this.booksInSeries,
      required this.thumb});

  @override
  List<Object?> get props =>
      [series, currentbook, nextBook, previousBook, booksInSeries, thumb];
}
