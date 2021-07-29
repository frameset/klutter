import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/repositories/reader_repository.dart';

part 'reader_state.dart';
part 'reader_event.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  final BookDto book;
  final ReaderRepository _readerRepository;
  int currentPage;
  ReaderBloc(this.book)
      : _readerRepository = ReaderRepository(book),
        currentPage = book.readProgress?.page ?? 1,
        super(ReaderInitial());

  @override
  Stream<ReaderState> mapEventToState(ReaderEvent event) async* {
    if (event is ReaderInitialLoad) {
      //get initial page and pass it back to the UI so user gets immediate feedback
      book.readProgress == null
          ? currentPage = 1
          : currentPage = book.readProgress!.page;
      yield ReaderPageReady(
          currentPage, await _readerRepository.getPageImage(currentPage));
      //now start caching pages around the initial page
      _readerRepository.updateReadPage(currentPage);
      _readerRepository.cacheAround(currentPage);
    } else if (event is ReaderGoToNextPage) {
      yield ReaderLoading(currentPage);
      if (currentPage == book.media.pagesCount) {
        yield ReaderReachedEnd(await _readerRepository.getNextBook());
      } else {
        if (!_readerRepository.pageMap.containsKey(currentPage)) {
          print("you are here");
          yield ReaderLoading(currentPage);
        }

        currentPage++;
        List<int> image = await _readerRepository.getPageImage(currentPage);
        yield ReaderPageReady(currentPage, image);
        await _readerRepository.updateReadPage(currentPage);
        _readerRepository.cacheAround(currentPage);
      }
    } else if (event is ReaderGoToPrevPage) {
      if (currentPage == 1) {
        yield ReaderReachedStart(await _readerRepository.getPrevBook());
      } else {
        yield ReaderLoading(currentPage);

        _readerRepository.updateReadPage(currentPage);
        currentPage--;
        yield ReaderPageReady(
            currentPage, await _readerRepository.getPageImage(currentPage));
        await _readerRepository.updateReadPage(currentPage);
        _readerRepository.cacheAround(currentPage);
      }
    } else if (event is ReaderGoToPage) {
      yield ReaderLoading(currentPage);
      currentPage = event.pageNumber;
      yield ReaderPageReady(
          currentPage, await _readerRepository.getPageImage(currentPage));
      await _readerRepository.updateReadPage(currentPage);
      _readerRepository.cacheAround(currentPage);
    } else if (event is ReaderGoNextbook) {
      yield ReaderLoading(currentPage);
      BookDto nextBook = await _readerRepository.getNextBook();
      yield ReaderReachedEnd(nextBook);
    } else if (event is ReaderReachedStart) {
      yield ReaderLoading(currentPage);
      try {
        BookDto prevBook = await _readerRepository.getPrevBook();
        yield ReaderReachedStart(prevBook);
      } on Exception catch (_) {
        yield ReaderNoPreviousBook();
      }
    }
  }

  // @override
  // Stream<Transition<ReaderEvent, ReaderState>> transformEvents(
  //     Stream<ReaderEvent> events,
  //     TransitionFunction<ReaderEvent, ReaderState> transitionFn) {
  //   return events
  //       .debounceTime(const Duration(milliseconds: 400))
  //       .switchMap(transitionFn);
  // }

  @override
  void onChange(change) {
    super.onChange(change);
    print(DateTime.now());
    print(change.nextState.toString());
  }
}
