import 'package:flutter/material.dart';
import 'package:klutter/business_logic/cubit/keepreading_cubit.dart';
import 'package:klutter/business_logic/cubit/ondeck_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/recently_added_series_cubit.dart';
import 'package:klutter/business_logic/cubit/recentlyaddedbooks_cubit.dart';
import 'package:klutter/business_logic/cubit/recentlyupdatedseries_cubit.dart';
import 'package:klutter/data/repositories/server_home_repository.dart';
import 'package:klutter/presentation/widgets/search.dart';
import 'package:klutter/presentation/widgets/server_drawer.dart';
import 'package:klutter/presentation/widgets/book_card.dart';
import 'package:klutter/presentation/widgets/series_card.dart';

class ServerHome extends StatelessWidget {
  static const routeName = '/serverHome';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: RepositoryProvider(
        create: (context) => ServerHomeRepository(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Server Home"),
              actions: [KlutterSearchButton()],
            ),
            drawer: ServerDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: [
                  KeepReading(),
                  OnDeck(),
                  RecentlyaddedSeries(),
                  RecentlyupdatedSeries(),
                  RecentlyaddedBooks(),
                ],
              ),
            )),
      ),
    );
  }
}

class RecentlyupdatedSeries extends StatelessWidget {
  const RecentlyupdatedSeries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyUpdatedSeriesCubit, RecentlyUpdatedSeriesState>(
      bloc: RecentlyUpdatedSeriesCubit(context.read<ServerHomeRepository>())
        ..getRecentlyUpdatedSeries(),
      builder: (context, state) {
        if (state is RecentlyUpdatedSeriesInitial ||
            state is RecentlyUpdatedSeriesLoading) {
          return SizedBox.shrink();
        } else if (state is RecentlyUpdatedSeriesEmpty) {
          return SizedBox.shrink();
        } else if (state is RecentlyUpdatedSeriesLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recently Updated Series",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.series.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SeriesCard(state.series[index]);
                  },
                ),
              )
            ],
          );
        } else {
          return ErrorLoading();
        }
      },
    );
  }
}

class KeepReading extends StatelessWidget {
  const KeepReading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeepReadingCubit, KeepReadingState>(
      builder: (context, state) {
        if (state is KeepReadingInitial || state is KeepReadingLoading) {
          return SizedBox.shrink();
        } else if (state is KeepReadingEmpty) {
          return SizedBox.shrink();
        } else if (state is KeepReadingLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Keep Reading",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookCard(state.books[index]);
                  },
                ),
              ),
            ],
          );
        } else {
          return ErrorLoading();
        }
      },
      bloc: KeepReadingCubit(context.read<ServerHomeRepository>())
        ..getKeepReading(),
    );
  }
}

class RecentlyaddedSeries extends StatelessWidget {
  const RecentlyaddedSeries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyAddedSeriesCubit, RecentlyAddedSeriesState>(
      builder: (context, state) {
        if (state is RecentlyAddedSeriesInitial ||
            state is RecentlyAddedSeriesLoading) {
          return SizedBox.shrink();
        } else if (state is RecentlyAddedSeriesEmpty) {
          return SizedBox.shrink();
        } else if (state is RecentlyAddedSeriesLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recently Added Series",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.series.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SeriesCard(state.series[index]);
                  },
                ),
              ),
            ],
          );
        } else {
          return ErrorLoading();
        }
      },
      bloc: RecentlyAddedSeriesCubit(context.read<ServerHomeRepository>())
        ..getRecentlyAddedSeries(),
    );
  }
}

class RecentlyaddedBooks extends StatelessWidget {
  const RecentlyaddedBooks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyaddedbooksCubit, RecentlyaddedbooksState>(
      builder: (context, state) {
        if (state is RecentlyaddedbooksInitial ||
            state is RecentlyaddedbooksLoading) {
          return SizedBox.shrink();
        } else if (state is RecentlyaddedbooksLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recently Added Books",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return BookCard(state.books[index]);
                  },
                  itemCount: state.books.length,
                ),
              ),
            ],
          );
        } else if (state is RecentlyaddedbooksEmpty) {
          return SizedBox.shrink();
        } else {
          return ErrorLoading();
        }
      },
      bloc: RecentlyaddedbooksCubit(context.read<ServerHomeRepository>())
        ..getRecentlyaddedBooks(),
    );
  }
}

class OnDeck extends StatelessWidget {
  const OnDeck({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OndeckCubit, OndeckState>(
      builder: (context, state) {
        if (state is OndeckInitial || state is OndeckLoading) {
          return SizedBox.shrink();
        } else if (state is OndeckLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "On Deck",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookCard(state.books[index]);
                    }),
              ),
            ],
          );
        } else if (state is OnDeckEmpty) {
          return SizedBox.shrink();
        } else {
          return ErrorLoading();
        }
      },
      bloc: OndeckCubit(context.read<ServerHomeRepository>())..getOndeck(),
    );
  }
}

class ErrorLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text("Error loading")
        ],
      ),
    );
  }
}
