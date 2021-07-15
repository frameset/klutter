import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/bloc/series_books_bloc.dart';
import 'package:klutter/business_logic/cubit/series_info_cubit.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/widgets/book_card.dart';
import 'package:klutter/business_logic/cubit/series_thumbnail_cubit.dart';
import 'package:klutter/presentation/widgets/search.dart';
import 'package:sizer/sizer.dart';

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
            create: (context) =>
                SeriesBooksBloc(series)..add(SeriesBooksGetPage(0)))
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [KlutterSearchButton()],
            title: Text("Series: " + series.metadata.title),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Info",
                ),
                Tab(text: "Books"),
              ],
              automaticIndicatorColorAdjustment: true,
            ),
          ),
          body: TabBarView(children: [
            InfoTab(series: series),
            BooksTab(),
          ]),
        ),
      ),
    );
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: BlocBuilder<SeriesThumbnailCubit,
                            SeriesThumbnailState>(builder: (context, state) {
                          if (state is SeriesThumbnailReady) {
                            return Image.memory(
                              Uint8List.fromList(state.thumbnail),
                              fit: BoxFit.contain,
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            series.metadata.title,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                          // Divider(),
                          Text(
                            series.booksMetadata.releaseDate?.year.toString() ??
                                "",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Text(
                            series.metadata.publisher,
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          Text(
                            series.booksCount == 1
                                ? "1 book"
                                : series.booksCount.toString() + " books",
                            style: TextStyle(fontSize: 8.sp),
                          ),
                        ],
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
                            : Wrap(
                                runSpacing: 1.w,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                      Text(
                                        "TAGS",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ] +
                                    series.metadata.tags
                                        .map((e) => Chip(label: Text(e)))
                                        .toList()),
                        series.metadata.genres.length == 0
                            ? SizedBox.shrink()
                            : Wrap(
                                runSpacing: 1.w,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                      Text(
                                        "GENRE",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ] +
                                    series.metadata.genres
                                        .map((e) => Chip(
                                                label: Text(
                                              e,
                                              style: TextStyle(fontSize: 8.sp),
                                            )))
                                        .toList()),
                        Divider(),
                        series.booksMetadata.summary == ''
                            ? SizedBox.shrink()
                            : Text(
                                "Summary from book " +
                                    series.booksMetadata.summaryNumber
                                        .toString() +
                                    ":",
                                style: TextStyle(fontSize: 9.sp),
                              ),
                        Text(
                          series.booksMetadata.summary,
                          style: TextStyle(fontSize: 9.sp),
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class BooksTab extends StatelessWidget {
  const BooksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesBooksBloc, SeriesBooksState>(
      builder: (context, state) {
        if (state is SeriesBooksInitial) {
          return Container();
        } else if (state is SeriesBooksLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SeriesBooksReady) {
          return Column(
            children: [
              state.page.totalPages == 1
                  ? SizedBox.shrink()
                  : Expanded(
                      flex: 15,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              onPressed: state.page.first!
                                  ? null
                                  : () => context.read<SeriesBooksBloc>().add(
                                      SeriesBooksGetPage(
                                          state.page.number! - 1)),
                              child: Icon(Icons.chevron_left),
                            ),
                            ButtonBar(
                              children: [
                                Text("Go to Page "),
                                DropdownButton(
                                    onChanged: (value) {
                                      if (value as int != state.page.number) {
                                        context
                                            .read<SeriesBooksBloc>()
                                            .add(SeriesBooksGetPage(value));
                                      }
                                    },
                                    value: state.page.number,
                                    items: Iterable<int>.generate(
                                            state.page.totalPages!)
                                        .map<DropdownMenuItem<int>>((e) =>
                                            DropdownMenuItem<int>(
                                                value: e,
                                                child:
                                                    Text((e + 1).toString())))
                                        .toList()),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: state.page.last!
                                  ? null
                                  : () => context.read<SeriesBooksBloc>().add(
                                      SeriesBooksGetPage(
                                          state.page.number! + 1)),
                              child: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                  flex: 85,
                  child: GridView.builder(
                      itemCount: state.page.numberOfElements,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 200, maxCrossAxisExtent: 150),
                      itemBuilder: (context, index) {
                        return BookCard(state.page.content!.elementAt(index));
                      }))
            ],
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
