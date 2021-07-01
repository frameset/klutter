part of 'bookthumbnail_cubit.dart';

abstract class BookThumbnailState extends Equatable {
  const BookThumbnailState();

  @override
  List<Object> get props => [];
}

class BookThumbnailInitial extends BookThumbnailState {}

class BookThumbnailFailed extends BookThumbnailState {}

class BookThumbnailLoading extends BookThumbnailState {}

class BookThumbnailReady extends BookThumbnailState {
  final List<int> thumbnail;
  const BookThumbnailReady(this.thumbnail);

  @override
  List<Object> get props => [thumbnail];
}
