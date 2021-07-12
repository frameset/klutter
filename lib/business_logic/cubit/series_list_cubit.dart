import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:klutter/data/models/collectiondto.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/repositories/series_repository.dart';

part 'series_list_state.dart';

class SeriesListCubit extends Cubit<SeriesListState> {
  final LibraryDto? library;
  final CollectionDto? collection;
  final SeriesRepository repository;

  SeriesListCubit({
    this.library,
    this.collection,
    required this.repository,
  }) : super(SeriesListInitial());

  Future<void> getSeriesPage(int page) async {
    emit(SeriesListLoading());
    PageSeriesDto seriesPage =
        await repository.getSeries(page, library, collection);
    if (seriesPage.totalElements == 0) {
      emit(SeriesListEmpty());
    } else {
      emit(SeriesListReady(seriesPage));
    }
  }
}
