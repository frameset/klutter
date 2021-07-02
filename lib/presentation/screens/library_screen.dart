import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/bloc/library_view_bloc.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/presentation/widgets/search.dart';
import 'package:klutter/presentation/widgets/series_card.dart';
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
      child: Scaffold(
        drawer: ServerDrawer(),
        appBar: AppBar(
          title: Text(library?.name ?? "Libraries"),
          actions: [KlutterSearchButton()],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocProvider(
            create: (context) => LibraryViewBloc(),
            child: LibraryGrid(),
          ),
        ),
      ),
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
    _scrollController.addListener(_onScroll);
    _libraryViewBloc = context.read<LibraryViewBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final LibraryDto? library =
        ModalRoute.of(context)!.settings.arguments as LibraryDto?;
    _libraryViewBloc.add(LibraryViewLoad(library: library));
    return BlocBuilder<LibraryViewBloc, LibraryViewState>(
      builder: (context, state) {
        if (state is LibraryViewLoaded) {
          return GridView.builder(
              itemCount: state.end == true
                  ? state.series.length
                  : state.series.length + 1,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150, mainAxisExtent: 200),
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index >= state.series.length) {
                  if (state.end != true) {
                    return BottomLoader();
                  } else {
                    return SizedBox.shrink();
                  }
                } else {
                  return SeriesCard(state.series.elementAt(index));
                }
              });
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

  void _onScroll() {
    if (_isBottom) _libraryViewBloc.add(LibraryViewMore());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
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
