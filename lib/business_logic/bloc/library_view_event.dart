part of 'library_view_bloc.dart';

abstract class LibraryViewEvent extends Equatable {
  const LibraryViewEvent();

  @override
  List<Object?> get props => [];
}

class LibraryViewLoad extends LibraryViewEvent {
  final int page;
  final LibraryDto? library;
  LibraryViewLoad({
    required this.page,
    this.library,
  });

  @override
  List<Object?> get props => [page, library];
}

class LibraryViewMore extends LibraryViewEvent {}
