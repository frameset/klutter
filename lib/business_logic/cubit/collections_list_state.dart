part of 'collections_list_cubit.dart';

abstract class CollectionsListState extends Equatable {
  const CollectionsListState();

  @override
  List<Object> get props => [];
}

class CollectionsListInitial extends CollectionsListState {}

class CollectionsListEmpty extends CollectionsListState {}

class CollectionsListLoading extends CollectionsListState {}

class CollectionsListReady extends CollectionsListState {
  final PageCollectionDto collectionsPage;
  final Map<String, List<int>> thumbMap;
  final int mapLength;
  CollectionsListReady(this.collectionsPage, this.thumbMap, this.mapLength);

  @override
  List<Object> get props => [collectionsPage, thumbMap, mapLength];
}
