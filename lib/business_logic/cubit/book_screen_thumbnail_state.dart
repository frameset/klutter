part of 'book_screen_thumbnail_cubit.dart';

abstract class BookScreenThumbnailState extends Equatable {
  const BookScreenThumbnailState();

  @override
  List<Object> get props => [];
}

class BookScreenThumbnailInitial extends BookScreenThumbnailState {}

class BookScreenThumbnailLoaded extends BookScreenThumbnailState {
  final List<int> thumb;
  BookScreenThumbnailLoaded(this.thumb);

  @override
  List<Object> get props => [thumb];
}
