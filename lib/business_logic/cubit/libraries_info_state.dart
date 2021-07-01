part of 'libraries_info_cubit.dart';

abstract class LibrariesInfoState extends Equatable {
  const LibrariesInfoState();

  @override
  List<Object> get props => [];
}

class LibrariesInfoInitial extends LibrariesInfoState {}

class LibrariesInfoReady extends LibrariesInfoState {
  final List<LibraryDto> libraries;
  LibrariesInfoReady(this.libraries);

  List<Object> get props => [libraries];
}
