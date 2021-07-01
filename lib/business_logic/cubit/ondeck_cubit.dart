import 'package:bloc/bloc.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/repositories/server_home_repository.dart';

part 'ondeck_state.dart';

class OndeckCubit extends Cubit<OndeckState> {
  final ServerHomeRepository _repository;
  OndeckCubit(this._repository) : super(OndeckInitial());

  Future<void> getOndeck() async {
    emit(OndeckLoading());
    try {
      final List<BookDto> ondeckBooks = await _repository.getOndeck();
      if (ondeckBooks.isEmpty) {
        emit(OnDeckEmpty());
      } else {
        emit(OndeckLoaded(ondeckBooks));
      }
    } on Exception catch (_) {
      emit(OndeckError());
    }
  }
}
