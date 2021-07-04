import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/seriesdto.dart';

part 'series_info_state.dart';

class SeriesInfoCubit extends Cubit<SeriesInfoState> {
  ApiClient apiClient = ApiClient();
  SeriesDto series;
  SeriesInfoCubit(this.series) : super(SeriesInfoLoading());

  Future<void> getSeriesInfo() async {
    try {
      emit(SeriesInfoReady(
          await apiClient.seriesController.getSeriesById(series.id)));
    } on Exception catch (_) {
      emit(SeriesInfoFailed());
    }
  }
}
