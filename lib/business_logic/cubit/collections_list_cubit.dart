import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pagecollectiondto.dart';
import 'package:klutter/data/repositories/collection_repository.dart';

part 'collections_list_state.dart';

class CollectionsListCubit extends Cubit<CollectionsListState> {
  final LibraryDto? library;
  final CollectionsRepository repository;

  CollectionsListCubit({
    this.library,
    required this.repository,
  }) : super(CollectionsListInitial());

  Future<void> getCollectionPage(int page) async {
    Map<String, List<int>> thumbMap = {};
    int mapLength = 0;
    PageCollectionDto collectionsPage =
        await repository.getCollections(page, library);
    if (collectionsPage.totalElements == 0) {
      emit(CollectionsListEmpty());
    } else {
      emit(CollectionsListReady(collectionsPage, thumbMap, mapLength));

      collectionsPage.content!.forEach((element) async {
        List<int> thumb = await repository.getThumbnail(element.id);
        thumbMap[element.id] = thumb;
        mapLength++;
        emit(CollectionsListReady(collectionsPage, thumbMap, mapLength));
      });
    }
  }
}
