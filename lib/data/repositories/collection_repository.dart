import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/pagecollectiondto.dart';

class CollectionsRepository {
  Map<String, List<int>> thumbMap = {};
  final ApiClient _apiClient = ApiClient();
  // List<CollectionDto> collections = [];
  Future<PageCollectionDto> getCollections(
      int page, LibraryDto? library) async {
    return await _apiClient.collectionController.getCollections(
        libraryId: library == null ? null : [library.id],
        page: page,
        size: 100);
  }

  Future<List<int>> getThumbnail(String id) async {
    if (thumbMap[id] != null) {
      return thumbMap[id]!;
    } else {
      thumbMap[id] = await _apiClient.collectionController.getThumbnail(id);
      return thumbMap[id]!;
    }
  }
}
