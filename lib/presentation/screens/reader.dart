import 'dart:typed_data';

import 'package:klutter/business_logic/bloc/reader_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/page_thumbnail_cubit.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';
import 'package:klutter/presentation/widgets/page_thumbnail.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:sizer/sizer.dart';

class Reader extends StatefulWidget {
  static const routeName = '/reader';

  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  bool menuVisible = false;
  int currentSliderValue = 2;
  PageThumbnailCubit? pageThumbnailCubit;
  late PhotoViewScaleStateController scaleController;
  DismissDirection dismissDirection = DismissDirection.horizontal;

  @override
  void initState() {
    super.initState();
    _enterFullscreen();
    scaleController = PhotoViewScaleStateController();
  }

  @override
  Widget build(BuildContext context) {
    final BookDto currentbook =
        ModalRoute.of(context)?.settings.arguments as BookDto;
    pageThumbnailCubit ??= PageThumbnailCubit(currentbook);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ReaderBloc>(
              lazy: false,
              create: (context) =>
                  ReaderBloc(currentbook)..add(ReaderInitialLoad())),
        ],
        child: Scaffold(
          appBar: null,
          body: Builder(builder: (context) {
            return SizedBox.expand(
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: BlocConsumer<ReaderBloc, ReaderState>(
                      listener: (context, state) {
                        if (state is ReaderReachedEnd) {
                          Navigator.of(context).popAndPushNamed(
                              BookScreen.routeName,
                              arguments: state.nextBook);
                        } else if (state is ReaderReachedStart) {
                          Navigator.of(context).popAndPushNamed(
                              BookScreen.routeName,
                              arguments: state.prevBook);
                        } else if (state is ReaderPageReady) {
                          currentSliderValue = state.pageNumber;
                        }
                        // //Troubleshooting print statement
                        // else if (state is ReaderLoading) {
                        //   print(
                        //       "listener heard loading page ${state.pageNumber}");
                        // }
                      },
                      builder: (context, state) {
                        if (state is ReaderInitial) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ReaderLoading) {
                          print("loading page ${state.pageNumber}");
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ReaderFailed) {
                          return Center(
                              child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ));
                        } else if (state is ReaderPageReady) {
                          // scaleController.scaleState =
                          //     PhotoViewScaleState.initial;
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: Dismissible(
                              behavior: HitTestBehavior.translucent,
                              key: ValueKey<int>(state.pageNumber),
                              direction: dismissDirection,
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  context
                                      .read<ReaderBloc>()
                                      .add(ReaderGoToPrevPage());
                                } else {
                                  context
                                      .read<ReaderBloc>()
                                      .add(ReaderGoToNextPage());
                                }
                              },
                              resizeDuration: null,
                              child: PhotoView(
                                scaleStateChangedCallback: (scaleState) {
                                  print(scaleState);
                                  setState(() {
                                    if (scaleState !=
                                        PhotoViewScaleState.initial) {
                                      dismissDirection = DismissDirection.none;
                                    } else {
                                      dismissDirection =
                                          DismissDirection.horizontal;
                                    }
                                  });
                                },
                                scaleStateController: scaleController,
                                filterQuality: FilterQuality.high,
                                initialScale: PhotoViewComputedScale.contained,
                                minScale: PhotoViewComputedScale.contained,
                                gaplessPlayback: true,
                                enableRotation: false,
                                imageProvider: MemoryImage(
                                  Uint8List.fromList(state.pageImage),
                                ),
                              ),
                            ),
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
                    ),
                  ),
                  Row(children: [
                    Expanded(
                        flex: 20,
                        child: Container(
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context
                                    .read<ReaderBloc>()
                                    .add(ReaderGoToPrevPage());
                              }),
                        )),
                    Expanded(
                        flex: 60,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      menuVisible = !menuVisible;
                                    });
                                  },
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 20,
                      child: Container(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context
                                .read<ReaderBloc>()
                                .add(ReaderGoToNextPage());
                          },
                        ),
                      ),
                    ),
                  ]),
                  IgnorePointer(
                    ignoring: !menuVisible,
                    child: AnimatedOpacity(
                        opacity: menuVisible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: Theme.of(context).canvasColor,
                                // decoration: ,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                      ),
                                      onPressed: () => Navigator.of(context)
                                          .popAndPushNamed(BookScreen.routeName,
                                              arguments: currentbook),
                                    ),
                                    Expanded(
                                      child: Text(
                                        currentbook.metadata.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.grid_view),
                                      onPressed: () {
                                        showDialog<int>(
                                          context: context,
                                          builder: (context) {
                                            return BlocProvider.value(
                                              value: pageThumbnailCubit!
                                                ..getPageThumbnails(),
                                              child: PageThumbnailGridDialog(
                                                  book: currentbook),
                                            );
                                          },
                                        ).then((value) => context
                                            .read<ReaderBloc>()
                                            .add(ReaderGoToPage(value!)));
                                      },
                                    )
                                  ],
                                ),
                              ),
                              flex: 10,
                            ),
                            Expanded(flex: 70, child: Container()),
                            Expanded(
                              flex: 10,
                              child: SizedBox.expand(
                                child: Container(
                                  color: Theme.of(context).canvasColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.skip_previous),
                                          onPressed: () => context
                                              .read<ReaderBloc>()
                                              .add(ReaderGoPreviousBook())),
                                      BlocBuilder<ReaderBloc, ReaderState>(
                                        builder: (context, state) {
                                          return Expanded(
                                            child: Slider(
                                              value:
                                                  currentSliderValue.toDouble(),
                                              min: 1,
                                              max: currentbook.media.pagesCount
                                                  .toDouble(),
                                              divisions:
                                                  currentbook.media.pagesCount,
                                              label:
                                                  currentSliderValue.toString(),
                                              onChanged: (newvalue) {
                                                setState(() {
                                                  currentSliderValue =
                                                      newvalue.round();
                                                });
                                              },
                                              onChangeEnd: (newvalue) => context
                                                  .read<ReaderBloc>()
                                                  .add(ReaderGoToPage(
                                                      newvalue.round())),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.skip_next),
                                        onPressed: () => context
                                            .read<ReaderBloc>()
                                            .add(ReaderGoNextbook()),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _exitFullscreen();
    scaleController.dispose();
  }

  _enterFullscreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE);
  }

  _exitFullscreen() async {
    await FullScreen.exitFullScreen();
  }
}

class PageThumbnailGridDialog extends StatelessWidget {
  final BookDto book;
  const PageThumbnailGridDialog({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<PageThumbnailCubit, PageThumbnailState>(
        builder: (context, state) {
          if (state is PageThumbnailLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: state.pages.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 170),
              itemBuilder: (context, index) {
                return GridTile(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(
                                context, state.pages[index].number),
                            child: PageThumbnail(
                              book: book,
                              page: state.pages[index],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(state.pages[index].number.toString()),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
