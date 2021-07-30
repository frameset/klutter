import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/screens/series_screen.dart';

class SeriesCard extends StatelessWidget {
  final SeriesDto series;
  final ApiClient apiClient = ApiClient();

  SeriesCard(this.series);

  @override
  Widget build(BuildContext context) {
    String thumburl =
        apiClient.dio.options.baseUrl + "/api/v1/series/${series.id}/thumbnail";
    Map<String, String> header = {
      "Authorization": apiClient.dio.options.headers["Authorization"]
    };

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
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: thumburl,
                        httpHeaders: header,
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
