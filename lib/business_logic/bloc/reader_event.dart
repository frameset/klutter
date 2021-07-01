part of 'reader_bloc.dart';

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();
  List<Object> get props => [];
}

class ReaderInitialLoad extends ReaderEvent {}

class ReaderPageChanged extends ReaderEvent {
  final int pageNumber;
  ReaderPageChanged(this.pageNumber);

  List<Object> get props => [pageNumber];
}

class ReaderGoToPage extends ReaderEvent {
  final int pageNumber;
  ReaderGoToPage(this.pageNumber);

  List<Object> get props => [pageNumber];
}

class ReaderGoToNextPage extends ReaderEvent {}

class ReaderGoToPrevPage extends ReaderEvent {}

class ReaderGoPreviousBook extends ReaderEvent {}

class ReaderGoNextbook extends ReaderEvent {}
