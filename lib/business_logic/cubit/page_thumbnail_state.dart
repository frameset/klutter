part of 'page_thumbnail_cubit.dart';

abstract class PageThumbnailState extends Equatable {
  const PageThumbnailState();

  @override
  List<Object> get props => [];
}

class PageThumbnailInitial extends PageThumbnailState {}

class PageThumbnailFailed extends PageThumbnailState {}

class PageThumbnailLoaded extends PageThumbnailState {
  final List<PageDto> pages;
  PageThumbnailLoaded(this.pages);

  @override
  List<Object> get props => [pages];
}
