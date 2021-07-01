import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/bookdto.dart';

import 'package:klutter/data/repositories/server_home_repository.dart';

part 'keepreading_state.dart';

class KeepReadingCubit extends Cubit<KeepReadingState> {
  final ServerHomeRepository _repository;
  KeepReadingCubit(
    this._repository,
  ) : super(KeepReadingInitial());

  Future<void> getKeepReading() async {
    emit(KeepReadingLoading());
    try {
      final List<BookDto> books = await _repository.getKeepReading();
      if (books.isEmpty) {
        emit(KeepReadingEmpty());
      } else {
        emit(KeepReadingLoaded(books));
      }
    } on Exception catch (_) {
      emit(KeepReadingError());
    }
  }
}
