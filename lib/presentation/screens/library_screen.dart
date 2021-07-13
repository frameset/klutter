import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/bloc/library_view_bloc.dart';
import 'package:klutter/business_logic/cubit/collections_list_cubit.dart';
import 'package:klutter/business_logic/cubit/series_list_cubit.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/repositories/collection_repository.dart';
import 'package:klutter/data/repositories/series_repository.dart';
import 'package:klutter/presentation/screens/collection_screen.dart';
import 'package:klutter/presentation/widgets/collection_card.dart';
import 'package:klutter/presentation/widgets/search.dart';
import 'package:klutter/presentation/widgets/series_card.dart';
import 'package:klutter/presentation/widgets/series_grid_view.dart';
import 'package:klutter/presentation/widgets/server_drawer.dart';

class LibraryScreen extends StatefulWidget {
  static const String routeName = '/libraryScreen';
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final LibraryDto? library =
        ModalRoute.of(context)!.settings.arguments as LibraryDto?;

    return WillPopScope(
      onWillPop: () async => false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SeriesListCubit(
                  repository: SeriesRepository(), library: library)
                ..getSeriesPage(0)),
          BlocProvider(
              create: (context) => CollectionsListCubit(
                  repository: CollectionsRepository(), library: library)
                ..getCollectionPage(0))
        ],
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: ServerDrawer(),
            appBar: AppBar(
              title: Text(library?.name ?? "All Libraries"),
              actions: [KlutterSearchButton()],
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Browse",
                  ),
                  Tab(
                    text: "Collections",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<SeriesListCubit, SeriesListState>(
                    builder: (context, state) {
                      if (state is SeriesListInitial) {
                        return SizedBox.shrink();
                      } else if (state is SeriesListEmpty) {
                        return Center(
                          child: Text("No series found"),
                        );
                      } else if (state is SeriesListLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SeriesListReady) {
                        return SeriesGridView(state);
                      } else {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  // child: LibraryGrid(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CollectionGrid(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CollectionGrid extends StatelessWidget {
  const CollectionGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsListCubit, CollectionsListState>(
      builder: (context, state) {
        if (state is CollectionsListEmpty) {
          return Center(
            child: Text("No collections found"),
          );
        } else if (state is CollectionsListReady) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              state.collectionsPage.totalPages == 1
                  ? SizedBox.shrink()
                  : Expanded(
                      flex: 15,
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: state.collectionsPage.first!
                                ? null
                                : () => context
                                    .read<CollectionsListCubit>()
                                    .getCollectionPage(
                                        state.collectionsPage.number! - 1),
                            child: Icon(Icons.chevron_left),
                          ),
                          Row(
                            children: [
                              Text("Page "),
                              DropdownButton(
                                isDense: true,
                                onChanged: (value) {
                                  BlocProvider.of<CollectionsListCubit>(context)
                                      .getCollectionPage(value as int);
                                },
                                value: state.collectionsPage.number,
                                items: Iterable<int>.generate(
                                        state.collectionsPage.totalPages!)
                                    .map<DropdownMenuItem<int>>((e) =>
                                        DropdownMenuItem<int>(
                                            value: e,
                                            child: Text((e + 1).toString())))
                                    .toList(),
                              ),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: state.collectionsPage.last!
                                ? null
                                : () => context
                                    .read<CollectionsListCubit>()
                                    .getCollectionPage(
                                        state.collectionsPage.number! + 1),
                            child: Icon(Icons.chevron_right),
                          )
                        ],
                      ),
                    ),
              Expanded(
                flex: 85,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 200,
                    maxCrossAxisExtent: 150,
                  ),
                  itemCount: state.collectionsPage.content!.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, CollectionScreen.routeName,
                          arguments:
                              state.collectionsPage.content!.elementAt(index)),
                      child: CollectionCard(
                          state.collectionsPage.content!.elementAt(index))),
                ),
              ),
            ],
          );
        } else if (state is CollectionsListLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}

class LibraryGrid extends StatefulWidget {
  const LibraryGrid({
    Key? key,
  }) : super(key: key);

  @override
  _LibraryGridState createState() => _LibraryGridState();
}

class _LibraryGridState extends State<LibraryGrid> {
  final ScrollController _scrollController = ScrollController();
  LibraryViewBloc _libraryViewBloc = LibraryViewBloc();
  @override
  void initState() {
    print("Init state");
    super.initState();
    _libraryViewBloc = context.read<LibraryViewBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final LibraryDto? library =
        ModalRoute.of(context)!.settings.arguments as LibraryDto?;
    _libraryViewBloc.add(LibraryViewLoad(library: library, page: 0));
    return BlocBuilder<LibraryViewBloc, LibraryViewState>(
      builder: (context, state) {
        if (state is LibraryViewLoaded) {
          return Column(
            children: [
              state.seriesPage.totalPages == 1
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: state.seriesPage.first!
                              ? null
                              : () => context.read<LibraryViewBloc>().add(
                                  LibraryViewLoad(
                                      page: state.seriesPage.number! - 1)),
                          icon: Icon(Icons.chevron_left),
                        ),
                        Text("Go to Page "),
                        DropdownButton(
                            onChanged: (value) {
                              if (value as int != state.seriesPage.number) {
                                context
                                    .read<LibraryViewBloc>()
                                    .add(LibraryViewLoad(page: value));
                              }
                            },
                            value: state.seriesPage.number,
                            items: Iterable<int>.generate(
                                    state.seriesPage.totalPages!)
                                .map<DropdownMenuItem<int>>((e) =>
                                    DropdownMenuItem<int>(
                                        value: e,
                                        child: Text((e + 1).toString())))
                                .toList()),
                        IconButton(
                          onPressed: state.seriesPage.last!
                              ? null
                              : () => context.read<LibraryViewBloc>().add(
                                  LibraryViewLoad(
                                      page: state.seriesPage.number! + 1)),
                          icon: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
              Expanded(
                flex: 85,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 200, maxCrossAxisExtent: 150),
                  itemCount: state.seriesPage.numberOfElements,
                  itemBuilder: (context, index) =>
                      SeriesCard(state.seriesPage.content!.elementAt(index)),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
