part of 'keepreading_cubit.dart';

abstract class KeepReadingState extends Equatable {
  const KeepReadingState();

  @override
  List<Object> get props => [];
}

class KeepReadingInitial extends KeepReadingState {}

class KeepReadingLoading extends KeepReadingState {}

class KeepReadingEmpty extends KeepReadingState {}

class KeepReadingError extends KeepReadingState {}

class KeepReadingLoaded extends KeepReadingState {
  final List<BookDto> books;
  KeepReadingLoaded(
    this.books,
  );

  @override
  List<Object> get props => [books];
}
