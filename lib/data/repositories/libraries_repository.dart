import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/librarydto.dart';

class LibrariesRepository {
  ApiClient apiClient = ApiClient();
  Future<List<LibraryDto>> getAllLibraries() async {
    List<LibraryDto> _libraries =
        await apiClient.libraryController.getLibraries();
    return _libraries;
  }
}
