import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pagedto.dart';

class PageThumbnail extends StatelessWidget {
  final ApiClient apiClient = ApiClient();
  final BookDto book;
  final PageDto page;
  PageThumbnail({Key? key, required this.book, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumburl = apiClient.dio.options.baseUrl +
        "/api/v1/books/${book.id}/pages/${page.number}/thumbnail";
    Map<String, String> header = {
      "Authorization": apiClient.dio.options.headers["Authorization"]
    };

    return FadeInImage(
        placeholder: AssetImage("assets/images/cover.png"),
        image: NetworkImage(thumburl, headers: header));
  }
}
