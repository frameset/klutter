import 'package:bloc/bloc.dart';

enum SeriesTabNavState { info, books }

class SeriesTabNavCubit extends Cubit<SeriesTabNavState> {
  SeriesTabNavCubit() : super(SeriesTabNavState.info);

  void info() {
    emit(SeriesTabNavState.info);
  }

  void books() {
    emit(SeriesTabNavState.books);
  }
}
