part of 'page_thumbnail_cubit.dart';

abstract class PageThumbnailState extends Equatable {
  const PageThumbnailState();

  @override
  List<Object> get props => [];
}

class PageThumbnailInitial extends PageThumbnailState {}

class PageThumbnailFailed extends PageThumbnailState {}

class PageThumbnailLoaded extends PageThumbnailState {
  final Map<int, dynamic> thumbMap;
  final List<PageDto> pages;
  final int mapSize;
  PageThumbnailLoaded(this.pages, this.thumbMap, this.mapSize);

  @override
  List<Object> get props => [pages, thumbMap, mapSize];
  // List<Object> get props {
  //   print(thumbMap.keys.toList().toString());
  //   return [
  //     pages,
  //     thumbMap.keys.isEmpty
  //         ? 0
  //         : thumbMap.keys.toList().reduce((value, element) => value + element)
  //   ];
  // }
}
