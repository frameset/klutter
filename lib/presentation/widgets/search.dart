import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/bloc/search_bloc.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/repositories/thumbnail_repository.dart';
import 'package:klutter/presentation/widgets/book_list_tile.dart';
import 'package:klutter/presentation/widgets/series_list_tile.dart';

class KlutterSearchButton extends StatelessWidget {
  const KlutterSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: KlutterSearchDelegate(
                BlocProvider.of<SearchBloc>(context),
              ),
            );
          },
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class KlutterSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;
  KlutterSearchDelegate(this.searchBloc);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 3) {
      searchBloc.add(SearchQuery(query));
      return RepositoryProvider(
        create: (context) => ThumbnailRepository(),
        child: BlocBuilder<SearchBloc, SearchState>(
          bloc: searchBloc,
          builder: (context, state) {
            if (state is SearchReady) {
              final List<BookDto> bookResults = state.searchResults.bookResults;
              final List<SeriesDto> seriesResults =
                  state.searchResults.seriesResults;
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "Series",
                      ),
                      Tab(
                        text: "Books",
                      )
                    ],
                  ),
                  body: TabBarView(children: [
                    SeriesResultsPane(
                      seriesResults: seriesResults,
                    ),
                    BookResultsPane(bookResults: bookResults),
                  ]),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    } else {
      return Center(
        child: Text("Minimum query length is 4 characters"),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions (maybe? Not sure if needed)
    return Container();
  }
}

class SeriesResultsPane extends StatelessWidget {
  final List<SeriesDto> seriesResults;

  const SeriesResultsPane({
    Key? key,
    required this.seriesResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (seriesResults.isEmpty) {
      return Center(child: Text("No series found"));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(
                "Series Results",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(),
              itemCount: seriesResults.length,
              itemBuilder: (context, index) {
                return SeriesListTile(series: seriesResults.elementAt(index));
              },
            ),
          ),
        ],
      );
    }
  }
}

class BookResultsPane extends StatelessWidget {
  final List<BookDto> bookResults;

  const BookResultsPane({
    Key? key,
    required this.bookResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bookResults.isEmpty) {
      return Center(child: Text("No books found"));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(
                "Book Results",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(),
              itemCount: bookResults.length,
              itemBuilder: (context, index) {
                return BookListTile(book: bookResults.elementAt(index));
              },
            ),
          ),
        ],
      );
    }
  }
}
