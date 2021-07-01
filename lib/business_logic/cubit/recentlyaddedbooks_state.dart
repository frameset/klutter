part of 'recentlyaddedbooks_cubit.dart';

@immutable
abstract class RecentlyaddedbooksState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentlyaddedbooksInitial extends RecentlyaddedbooksState {}

class RecentlyaddedbooksLoading extends RecentlyaddedbooksState {}

class RecentlyaddedbooksLoaded extends RecentlyaddedbooksState {
  final List<BookDto> books;
  RecentlyaddedbooksLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class RecentlyaddedbooksError extends RecentlyaddedbooksState {}

class RecentlyaddedbooksEmpty extends RecentlyaddedbooksState {}
