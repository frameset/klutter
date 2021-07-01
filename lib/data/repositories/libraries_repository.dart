import 'package:klutter/data/dataproviders/client/library_controller.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/util/dio_helper.dart';

class LibrariesRepository {
  Future<List<LibraryDto>> getAllLibraries() async {
    LibraryController _libraryController = await getLibraryController();

    List<LibraryDto> _libraries = await _libraryController.getLibraries();
    return _libraries;
  }
}
