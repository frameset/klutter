import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/server_home_repository.dart';
import 'package:meta/meta.dart';

part 'recently_added_series_state.dart';

class RecentlyAddedSeriesCubit extends Cubit<RecentlyAddedSeriesState> {
  final ServerHomeRepository _repository;
  RecentlyAddedSeriesCubit(this._repository)
      : super(RecentlyAddedSeriesInitial());

  Future<void> getRecentlyAddedSeries() async {
    emit(RecentlyAddedSeriesLoading());
    try {
      final List<SeriesDto> series = await _repository.getRecentlyaddedSeries();
      if (series.isEmpty) {
        emit(RecentlyAddedSeriesEmpty());
      } else {
        emit(RecentlyAddedSeriesLoaded(series));
      }
    } on Exception catch (_) {
      emit(RecentlyAddedSeriesError());
    }
  }
}
