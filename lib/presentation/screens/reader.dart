import 'dart:typed_data';

import 'package:klutter/business_logic/bloc/reader_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fullscreen/fullscreen.dart';

class Reader extends StatefulWidget {
  static const routeName = '/reader';

  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  bool menuVisible = false;
  int currentSliderValue = 2;

  @override
  void initState() {
    super.initState();
    _enterFullscreen();
  }

  @override
  Widget build(BuildContext context) {
    final BookDto currentbook =
        ModalRoute.of(context)?.settings.arguments as BookDto;
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.bottom, SystemUiOverlay.top]);
        Navigator.popAndPushNamed(context, BookScreen.routeName,
            arguments: currentbook);
        return Future.value(true);
      },
      child: Scaffold(
        body: BlocProvider(
          lazy: false,
          create: (context) =>
              ReaderBloc(currentbook)..add(ReaderInitialLoad()),
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
                          } else if (state is ReaderLoading) {
                            print(
                                "listener heard loading page ${state.pageNumber}");
                          }
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
                            // currentPage = state.pageNumber;
                            print("rendering page ${state.pageNumber}");
                            return PhotoView(
                                loadingBuilder: (context, widgetchunkevent) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                                minScale: PhotoViewComputedScale.contained,
                                gaplessPlayback: true,
                                enableRotation: false,
                                imageProvider: MemoryImage(
                                    Uint8List.fromList(state.pageImage)));
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
                          flex: 15,
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
                          flex: 70,
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  menuVisible = !menuVisible;
                                });
                              },
                            ),
                          )),
                      Expanded(
                          flex: 15,
                          child: Container(
                              child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    context
                                        .read<ReaderBloc>()
                                        .add(ReaderGoToNextPage());
                                  }))),
                    ]),
                    AnimatedOpacity(
                        opacity: menuVisible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                    Expanded(
                                      child: Text(
                                        currentbook.metadata.title,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.grid_view),
                                      onPressed: () {},
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
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.skip_previous),
                                          onPressed: () => context
                                              .read<ReaderBloc>()
                                              .add(ReaderGoPreviousBook())),
                                      //Page slider goes here. (blocbuilder?)
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
                        ))
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _exitFullscreen();
  }

  _enterFullscreen() async {
    await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE);
  }

  _exitFullscreen() async {
    await FullScreen.exitFullScreen();
  }
}
