import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/series_thumbnail_cubit.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/screens/series_screen.dart';

class SeriesCard extends StatelessWidget {
  final SeriesDto series;
  final SeriesThumbnailCubit seriesThumbnailCubit;

  SeriesCard(this.series)
      : seriesThumbnailCubit = SeriesThumbnailCubit(series) {
    seriesThumbnailCubit.getThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: 125.0,
      child: Card(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SeriesScreen.routeName,
                arguments: series);
          },
          child: Container(
            margin: EdgeInsets.zero,
            width: 125.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 125.0,
                      //width: 100.0,
                      child: BlocBuilder<SeriesThumbnailCubit,
                          SeriesThumbnailState>(
                        bloc: seriesThumbnailCubit,
                        builder: (context, state) {
                          if (state is SeriesThumbnailInitial ||
                              state is SeriesThumbnailLoading) {
                            return Image.asset("assets/images/cover.png");
                          } else if (state is SeriesThumbnailReady) {
                            return Image.memory(
                              Uint8List.fromList(state.thumbnail),
                              fit: BoxFit.contain,
                            );
                          } else {
                            return Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          }
                        },
                      )
                      //  Image.memory(
                      //   Uint8List.fromList(thumb),
                      //   fit: BoxFit.contain,
                      // ),
                      ,
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                        color: Colors.orange,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          series.booksCount.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      child: Text(
                        '${series.metadata.title}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   child: Text(
                //     '${series.series.booksCount} Books',
                //     style: TextStyle(color: Colors.grey),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
