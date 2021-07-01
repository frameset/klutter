import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/server_home_repository.dart';

part 'recentlyupdatedseries_state.dart';

class RecentlyUpdatedSeriesCubit extends Cubit<RecentlyUpdatedSeriesState> {
  final ServerHomeRepository _repository;

  RecentlyUpdatedSeriesCubit(this._repository)
      : super(RecentlyUpdatedSeriesInitial());

  Future<void> getRecentlyUpdatedSeries() async {
    emit(RecentlyUpdatedSeriesLoading());
    try {
      final List<SeriesDto> series =
          await _repository.getRecentlyupdatedSeries();
      if (series.isEmpty) {
        emit(RecentlyUpdatedSeriesEmpty());
      } else {
        emit(RecentlyUpdatedSeriesLoaded(series));
      }
    } on Exception catch (_) {
      emit(RecentlyUpdatesSeriesError());
    }
  }
}
