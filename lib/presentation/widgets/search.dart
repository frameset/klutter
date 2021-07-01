import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/bloc/search_bloc.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';
import 'package:klutter/presentation/screens/series_screen.dart';

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
  int selectedTabIndex = 0;
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
    // TODO: implement buildResults
    if (query.length > 3) {
      searchBloc.add(SearchQuery(query));
      return BlocBuilder<SearchBloc, SearchState>(
        bloc: searchBloc,
        builder: (context, state) {
          if (state is SearchReady) {
            List<BookDto> bookResults = state.searchResults.bookResults;
            List<SeriesDto> seriesResults = state.searchResults.seriesResults;
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
                  SeriesResultsPane(seriesResults: seriesResults),
                  BookResultsPane(bookResults: bookResults),
                ]),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
                return ListTile(
                  title: Text(seriesResults.elementAt(index).name),
                  subtitle: Text(seriesResults.elementAt(index).booksCount == 1
                      ? "1 book"
                      : seriesResults.elementAt(index).booksCount.toString() +
                          " books"),
                  onTap: () {
                    Navigator.pushNamed(context, SeriesScreen.routeName,
                        arguments: seriesResults.elementAt(index));
                  },
                );
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
                return ListTile(
                  title: Text(bookResults.elementAt(index).name),
                  onTap: () {
                    Navigator.pushNamed(context, BookScreen.routeName,
                        arguments: bookResults.elementAt(index));
                  },
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
