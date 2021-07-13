part of 'reader_bloc.dart';

abstract class ReaderState extends Equatable {
  ReaderState();

  @override
  List<Object?> get props => [];
}

class ReaderInitial extends ReaderState {}

class ReaderFailed extends ReaderState {}

class ReaderLoading extends ReaderState {
  final int? pageNumber;
  ReaderLoading(this.pageNumber);

  @override
  List<Object?> get props => [pageNumber];
}

class ReaderPageReady extends ReaderState {
  final List<int> pageImage;
  final int pageNumber;
  ReaderPageReady(this.pageNumber, this.pageImage);

  List<Object> get props => [pageNumber];
}

class ReaderReachedEnd extends ReaderState {
  final BookDto nextBook;
  ReaderReachedEnd(this.nextBook);

  List<Object> get props => [nextBook.id];
}

class ReaderReachedStart extends ReaderState {
  final BookDto prevBook;
  ReaderReachedStart(this.prevBook);

  List<Object> get props => [prevBook.id];
}

class ReaderNoPreviousBook extends ReaderState {}
