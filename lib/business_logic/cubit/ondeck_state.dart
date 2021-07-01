part of 'ondeck_cubit.dart';

@immutable
abstract class OndeckState extends Equatable {
  @override
  List<Object> get props => [];
}

class OndeckInitial extends OndeckState {}

class OndeckLoading extends OndeckState {}

class OndeckLoaded extends OndeckState {
  final List<BookDto> books;
  OndeckLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class OndeckError extends OndeckState {}

class OnDeckEmpty extends OndeckState {}
