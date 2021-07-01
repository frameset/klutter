import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

part 'series_thumbnail_state.dart';

class SeriesThumbnailCubit extends Cubit<SeriesThumbnailState> {
  SeriesDto series;
  SeriesThumbnailCubit(this.series) : super(SeriesThumbnailInitial());

  Future<void> getThumbnail() async {
    emit(SeriesThumbnailLoading());
    try {
      SeriesController seriesController = await getSeriesController();
      List<int> thumbnail = await seriesController.getThumbnail(series.id);
      emit(SeriesThumbnailReady(thumbnail));
    } on Exception catch (_) {
      emit(SeriesThumbnailFailed());
    }
  }
}
