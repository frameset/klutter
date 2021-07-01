import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/series_books_cubit.dart';
import 'package:klutter/business_logic/cubit/series_info_cubit.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/widgets/book_card.dart';
import 'package:klutter/business_logic/cubit/series_thumbnail_cubit.dart';
import 'package:klutter/presentation/widgets/search.dart';

class SeriesScreen extends StatefulWidget {
  static const routeName = '/seriesScreen';
  const SeriesScreen({Key? key}) : super(key: key);

  @override
  _SeriesScreenState createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final SeriesDto series =
        ModalRoute.of(context)!.settings.arguments as SeriesDto;
    return MultiBlocProvider(
        providers: [
          BlocProvider<SeriesThumbnailCubit>(
            create: (context) => SeriesThumbnailCubit(series)..getThumbnail(),
          ),
          BlocProvider<SeriesInfoCubit>(
              lazy: false,
              create: (context) => SeriesInfoCubit(series)..getSeriesInfo()),
          BlocProvider(
              create: (context) => SeriesBooksCubit(series)..getBookPage(0))
        ],
        child: Scaffold(
          appBar: AppBar(
            actions: [KlutterSearchButton()],
            title: Text("Series: " + series.metadata.title),
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => _onTap(index),
              currentIndex: selectedTabIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "Info",
                  icon: Icon(Icons.info_outline),
                  activeIcon: Icon(Icons.info),
                ),
                BottomNavigationBarItem(
                  label: "Books",
                  icon: Icon(Icons.library_books_outlined),
                  activeIcon: Icon(Icons.library_books),
                ),
              ]),
          body: <Widget>[
            InfoTab(series: series),
            BooksTab(),
          ].elementAt(selectedTabIndex),
        ));
  }

  void _onTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}

class InfoTab extends StatelessWidget {
  const InfoTab({
    Key? key,
    required this.series,
  }) : super(key: key);

  final SeriesDto series;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        BlocBuilder<SeriesThumbnailCubit, SeriesThumbnailState>(
                            builder: (context, state) {
                      if (state is SeriesThumbnailReady) {
                        return Image.memory(
                            Uint8List.fromList(state.thumbnail));
                      } else {
                        return Image.asset("assets/images/cover.png");
                      }
                    }),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            series.metadata.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            series.booksMetadata.releaseDate?.year.toString() ??
                                "",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(series.metadata.publisher),
                          Text(series.booksCount == 1
                              ? "1 book"
                              : series.booksCount.toString() + " books"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      series.metadata.tags.length == 0
                          ? SizedBox.shrink()
                          : SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                        Text(
                                          "TAGS",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ] +
                                      series.metadata.tags
                                          .map((e) => Chip(label: Text(e)))
                                          .toList())),
                      series.metadata.genres.length == 0
                          ? SizedBox.shrink()
                          : SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                        Text(
                                          "GENRE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ] +
                                      series.metadata.genres
                                          .map((e) => Chip(label: Text(e)))
                                          .toList())),
                      Text("Summary from book " +
                          series.booksMetadata.summaryNumber.toString() +
                          ":"),
                      Divider(),
                      Text(
                        series.booksMetadata.summary,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}

class BooksTab extends StatelessWidget {
  const BooksTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesBooksCubit, SeriesBooksState>(
        builder: (context, state) {
      if (state is SeriesBooksReady) {
        if (state.page.totalPages == 1) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 199.0),
              itemCount: state.page.numberOfElements,
              itemBuilder: (context, index) {
                return BookCard(state.page.content!.elementAt(index));
              });
        } else {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.page.totalPages,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: 30, minWidth: 30),
                          child: ElevatedButton(
                            child: Text(
                              (i + 1).toString(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Color(Colors.white.value)),
                            ),
                            onPressed: () =>
                                context.read<SeriesBooksCubit>().getBookPage(i),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.page.numberOfElements,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 190, mainAxisExtent: 200),
                    itemBuilder: (context, index) {
                      return BookCard(state.page.content!.elementAt(index));
                    }),
              )
            ],
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
