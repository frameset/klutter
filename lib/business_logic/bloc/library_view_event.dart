part of 'library_view_bloc.dart';

abstract class LibraryViewEvent extends Equatable {
  const LibraryViewEvent();

  @override
  List<Object> get props => [];
}

class LibraryViewLoad extends LibraryViewEvent {
  final LibraryDto? library;
  LibraryViewLoad({
    this.library,
  });
}

class LibraryViewMore extends LibraryViewEvent {}
