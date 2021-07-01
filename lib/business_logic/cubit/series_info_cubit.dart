import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/dataproviders/client/series_controller.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/util/dio_helper.dart';

part 'series_info_state.dart';

class SeriesInfoCubit extends Cubit<SeriesInfoState> {
  SeriesDto series;
  SeriesInfoCubit(this.series) : super(SeriesInfoLoading());

  Future<void> getSeriesInfo() async {
    try {
      SeriesController seriesController = await getSeriesController();
      emit(SeriesInfoReady(await seriesController.getSeriesById(series.id)));
    } on Exception catch (_) {
      emit(SeriesInfoFailed());
    }
  }
}
