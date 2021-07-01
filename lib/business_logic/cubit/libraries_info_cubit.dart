import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/repositories/libraries_repository.dart';

part 'libraries_info_state.dart';

class LibrariesInfoCubit extends Cubit<LibrariesInfoState> {
  LibrariesRepository _repository = LibrariesRepository();
  LibrariesInfoCubit() : super(LibrariesInfoInitial());

  Future<void> getAllLibraries() async {
    List<LibraryDto> libraries = await _repository.getAllLibraries();
    emit(LibrariesInfoReady(libraries));
  }
}
