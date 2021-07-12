import 'package:flutter/material.dart';
import 'package:klutter/data/models/bookdto.dart';

class ReadProgressBar extends StatelessWidget {
  const ReadProgressBar({
    Key? key,
    required this.book,
  }) : super(key: key);

  final BookDto book;

  @override
  Widget build(BuildContext context) {
    if (book.readProgress?.page != null) {
      return Row(
        children: [
          Expanded(
            flex:
                (book.readProgress!.page / book.media.pagesCount * 100).toInt(),
            child: Container(
              color: Colors.orange,
              height: 5,
            ),
          ),
          Expanded(
            flex: 100 -
                (book.readProgress!.page / book.media.pagesCount * 100).toInt(),
            child: Container(
              color: Colors.orange.withOpacity(0.33),
              height: 5,
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
