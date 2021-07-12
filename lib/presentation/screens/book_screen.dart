import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:klutter/business_logic/cubit/book_screen_more_menu_cubit.dart';
import 'package:klutter/business_logic/cubit/bookscreen_info_cubit.dart';
import 'package:klutter/business_logic/cubit/bookscreen_navbar_cubit.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/repositories/book_screen_repository.dart';
import 'package:klutter/presentation/screens/reader.dart';
import 'package:klutter/presentation/screens/series_screen.dart';
import 'package:klutter/presentation/widgets/book_progress_bar.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:flutter_bloc/flutter_bloc.dart';

class BookScreen extends StatefulWidget {
  static const routeName = '/bookScreen';

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    final BookDto currentbook =
        ModalRoute.of(context)!.settings.arguments as BookDto;

    return RepositoryProvider(
        create: (context) => BookScreenRepository(currentbook),
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  lazy: false,
                  create: (context) =>
                      BookscreenInfoCubit(context.read<BookScreenRepository>())
                        ..getInfo()),
              BlocProvider(
                create: (context) =>
                    BookscreenNavbarCubit(context.read<BookScreenRepository>()),
              ),
              BlocProvider(
                create: (context) => BookScreenMoreMenuCubit(
                    context.read<BookScreenRepository>()),
              ),
            ],
            child: BlocListener<BookscreenNavbarCubit, BookscreenNavbarState>(
              listener: (context, state) {
                if (state is BookscreenNoNextBook) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You are at the last book")));
                } else if (state is BookscreenNoPrevBook) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("You are at the first book"),
                  ));
                } else if (state is BookscreenGoNextBook) {
                  Navigator.popAndPushNamed(context, BookScreen.routeName,
                      arguments: state.nextbook);
                } else if (state is BookscreenGoPrevBook) {
                  Navigator.popAndPushNamed(context, BookScreen.routeName,
                      arguments: state.prevbook);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(currentbook.metadata.title),
                  actions: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: () {
                            context.read<BookscreenNavbarCubit>().tryGoPrev();
                          },
                        );
                      },
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          context.read<BookscreenNavbarCubit>().tryGoNext();
                        },
                      );
                    }),
                    MoreMenu()
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: BlocBuilder<BookscreenInfoCubit,
                                  BookscreenInfoState>(
                                builder: (context, state) {
                                  if (state is BookscreenInfoInitial) {
                                    return BookScreenImage(
                                        key: UniqueKey(),
                                        currentbook: currentbook);
                                  } else if (state is BookscreenInfoReady) {
                                    return BookScreenImage(
                                      key: UniqueKey(),
                                      currentbook: state.currentbook,
                                      image: state.thumb,
                                    );
                                  } else
                                    return Container();
                                },
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<BookscreenInfoCubit,
                                          BookscreenInfoState>(
                                        builder: (context, state) {
                                          if (state is BookscreenInfoReady) {
                                            return Column(
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      primary: Colors.blue),
                                                  child: Text(state.series.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                            context,
                                                            SeriesScreen
                                                                .routeName,
                                                            arguments:
                                                                state.series)
                                                        .then((value) => context
                                                            .read<
                                                                BookscreenInfoCubit>()
                                                            .getInfo());
                                                  },
                                                ),
                                                Divider(),
                                              ],
                                            );
                                          } else {
                                            return SizedBox.shrink();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        currentbook.metadata.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '#' + currentbook.metadata.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      currentbook.metadata.releaseDate == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              (DateFormat('yMMMMd').format(
                                                  currentbook
                                                      .metadata.releaseDate!)),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
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
                                currentbook.metadata.tags.length == 0
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
                                                currentbook.metadata.tags
                                                    .map((e) =>
                                                        Chip(label: Text(e)))
                                                    .toList())),
                                Text(
                                  currentbook.metadata.summary,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.menu_book),
                  label: Text("Read"),
                  onPressed: () {
                    //enter reading mode
                    Navigator.popAndPushNamed(context, Reader.routeName,
                            arguments: currentbook)
                        .then((value) =>
                            context.read<BookscreenInfoCubit>().getInfo());
                  },
                ),
              ),
            )));
  }
}

class BookScreenImage extends StatelessWidget {
  final List<int>? image;
  BookScreenImage({
    Key? key,
    required this.currentbook,
    this.image,
  }) : super(key: key);

  final BookDto currentbook;

  @override
  Widget build(BuildContext context) {
    Image cover = null != image
        ? Image.memory(Uint8List.fromList(image!))
        : Image.asset("assets/images/cover.png");
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            foregroundDecoration: currentbook.readProgress == null
                ? const RotatedCornerDecoration(
                    color: Colors.orange,
                    geometry: const BadgeGeometry(
                        width: 20, height: 20, cornerRadius: 0),
                  )
                : null,
            child: cover,
          ),
        ),
        if (currentbook.readProgress != null &&
            currentbook.readProgress?.completed != true)
          Align(
              alignment: Alignment.bottomCenter,
              child: ReadProgressBar(book: currentbook)),
      ],
    );
  }
}

class MoreMenu extends StatelessWidget {
  const MoreMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookScreenMoreMenuCubit, BookScreenMoreMenuState>(
      listener: (context, state) {
        if (state is BookScreenMoreMenuMarkReadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: [
              Icon(
                Icons.error_rounded,
                color: Colors.red,
              ),
              Text("Failed to mark as read"),
            ],
          )));
        } else if (state is BookScreenMoreMenuMarkReadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              Text("Successfully marked as read"),
            ],
          )));
          context.read<BookscreenInfoCubit>().getInfo();
        } else if (state is BookScreenMoreMenuMarkUnreadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: [
              Icon(
                Icons.error_rounded,
                color: Colors.red,
              ),
              Text("Failed to mark as unread"),
            ],
          )));
        } else if (state is BookScreenMoreMenuMarkUnreadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              Text("Successfully marked as unread"),
            ],
          )));
          context.read<BookscreenInfoCubit>().getInfo();
        }
      },
      child: PopupMenuButton<MoreMenuChoice>(
          icon: Icon(Icons.more_vert),
          onSelected: (MoreMenuChoice choice) {
            if (choice == MoreMenuChoice.analyse) {
              context.read<BookScreenMoreMenuCubit>().analyseMetadata();
            } else if (choice == MoreMenuChoice.refresh) {
              context.read<BookScreenMoreMenuCubit>().refreshMetadata();
            } else if (choice == MoreMenuChoice.markRead) {
              context.read<BookScreenMoreMenuCubit>().markAsRead();
            } else if (choice == MoreMenuChoice.markUnread) {
              context.read<BookScreenMoreMenuCubit>().markAsUnread();
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<MoreMenuChoice>>[
                const PopupMenuItem<MoreMenuChoice>(
                  value: MoreMenuChoice.analyse,
                  child: Text("Analyse"),
                ),
                const PopupMenuItem<MoreMenuChoice>(
                  value: MoreMenuChoice.refresh,
                  child: Text("Refresh metadata"),
                ),
                const PopupMenuItem<MoreMenuChoice>(
                  value: MoreMenuChoice.markRead,
                  child: Text("Mark as read"),
                ),
                const PopupMenuItem<MoreMenuChoice>(
                  value: MoreMenuChoice.markUnread,
                  child: Text("Mark as unread"),
                )
              ]),
    );
  }
}

enum MoreMenuChoice { analyse, refresh, markRead, markUnread }
