import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';

class BookListTile extends StatelessWidget {
  final BookDto book;
  final ApiClient apiClient = ApiClient();

  BookListTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String thumburl =
        apiClient.dio.options.baseUrl + "/api/v1/books/${book.id}/thumbnail";
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
      title: Text(book.name),
      onTap: () {
        Navigator.pushNamed(context, BookScreen.routeName, arguments: book);
      },
    );
  }
}
