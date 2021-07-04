import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/seriesdto.dart';

part 'series_thumbnail_state.dart';

class SeriesThumbnailCubit extends Cubit<SeriesThumbnailState> {
  ApiClient apiClient = ApiClient();
  SeriesDto series;
  SeriesThumbnailCubit(this.series) : super(SeriesThumbnailInitial());

  Future<void> getThumbnail() async {
    emit(SeriesThumbnailLoading());
    try {
      List<int> thumbnail =
          await apiClient.seriesController.getThumbnail(series.id);
      emit(SeriesThumbnailReady(thumbnail));
    } on Exception catch (_) {
      emit(SeriesThumbnailFailed());
    }
  }
}
