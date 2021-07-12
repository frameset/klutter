part of 'bookscreen_navbar_cubit.dart';

abstract class BookscreenNavbarState extends Equatable {
  const BookscreenNavbarState();

  @override
  List<Object> get props => [];
}

class BookscreenNavbarInitial extends BookscreenNavbarState {}

// class BookscreenNavbarMenuReady extends BookscreenNavbarState {
//   final List<BookDto> booksInSeries;
//   BookscreenNavbarMenuReady(this.booksInSeries);

//   @override
//   List<Object> get props => [booksInSeries];
// }

class BookscreenGoNextBook extends BookscreenNavbarState {
  final BookDto nextbook;
  BookscreenGoNextBook({
    required this.nextbook,
  });
}

class BookscreenGoPrevBook extends BookscreenNavbarState {
  final BookDto prevbook;
  BookscreenGoPrevBook({
    required this.prevbook,
  });
}

class BookscreenNoNextBook extends BookscreenNavbarState {}

class BookscreenNoPrevBook extends BookscreenNavbarState {}
