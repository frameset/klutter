import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/repositories/book_screen_repository.dart';

part 'bookscreen_navbar_state.dart';

class BookscreenNavbarCubit extends Cubit<BookscreenNavbarState> {
  List<BookDto>? booksInSeries;

  final BookScreenRepository repository;
  BookscreenNavbarCubit(this.repository) : super(BookscreenNavbarInitial());

  // Future<void> getSeriesMenu() async {
  //   try {
  //     booksInSeries ??= await repository.getBooksInSeries();
  //     emit(BookscreenNavbarMenuReady(booksInSeries!));
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> tryGoNext() async {
    try {
      BookDto? nextbook = await repository.getNextBook();
      nextbook != null
          ? emit(BookscreenGoNextBook(nextbook: nextbook))
          : emit(BookscreenNoNextBook());
    } on Exception catch (e) {
      print(e);
      emit(BookscreenNoNextBook());
      // getSeriesMenu();
    }
  }

  Future<void> tryGoPrev() async {
    try {
      BookDto? prevbook = await repository.getPreviousBook();
      prevbook != null
          ? emit(BookscreenGoPrevBook(prevbook: prevbook))
          : emit(BookscreenNoPrevBook());
    } on Exception catch (e) {
      print(e);
      emit(BookscreenNoPrevBook());
      // getSeriesMenu();
    }
  }
}
