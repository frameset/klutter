import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'book_progress_bar.dart';

class BookCard extends StatelessWidget {
  final BookDto book;
  final ApiClient apiClient = ApiClient();

  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    String thumburl =
        apiClient.dio.options.baseUrl + "/api/v1/books/${book.id}/thumbnail";
    Map<String, String> header = {
      "Authorization": apiClient.dio.options.headers["Authorization"]
    };

    return GestureDetector(
      //Add navigation to series route when done
      onTap: () {
        Navigator.pushNamed(context, BookScreen.routeName, arguments: book);
      },
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 250, maxWidth: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 80,
                child: Container(
                  foregroundDecoration: book.readProgress == null
                      ? const RotatedCornerDecoration(
                          color: Colors.orange,
                          geometry: const BadgeGeometry(
                              width: 20, height: 20, cornerRadius: 0),
                        )
                      : null,
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: thumburl,
                    httpHeaders: header,
                  ),
                ),
              ),
              book.readProgress != null
                  ? ReadProgressBar(book: book)
                  : SizedBox.shrink(),
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${book.metadata.number} - ${book.metadata.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
