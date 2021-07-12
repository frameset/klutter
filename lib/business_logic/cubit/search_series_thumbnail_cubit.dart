import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:klutter/data/repositories/thumbnail_repository.dart';

part 'search_series_thumbnail_state.dart';

class SearchSeriesThumbnailCubit extends Cubit<SearchSeriesThumbnailState> {
  final ThumbnailRepository _repository;
  SearchSeriesThumbnailCubit(
    this._repository,
  ) : super(SearchSeriesThumbnailInitial());

  Future<void> getThumbnail(String seriesid) async {
    List<int> thumb = await _repository.getSeriesThumb(seriesid);
    emit(SearchSeriesThumbnailReady(thumb: thumb));
  }
}
