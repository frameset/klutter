import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/presentation/screens/series_screen.dart';

class SeriesListTile extends StatelessWidget {
  final SeriesDto series;
  final ApiClient apiClient = ApiClient();
  SeriesListTile({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumburl =
        apiClient.dio.options.baseUrl + "/api/v1/series/${series.id}/thumbnail";
    Map<String, String> header = {
      "Authorization": apiClient.dio.options.headers["Authorization"]
    };

    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(
          thumburl,
          headers: header,
        ),
        placeholder: AssetImage("assets/images/cover.png"),
      ),
      title: Text(series.name),
      subtitle: Text(series.booksCount == 1
          ? "1 book"
          : series.booksCount.toString() + " books"),
      onTap: () {
        Navigator.pushNamed(context, SeriesScreen.routeName, arguments: series);
      },
    );
  }
}
