import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/presentation/screens/book_screen.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:klutter/business_logic/cubit/bookthumbnail_cubit.dart';
import 'book_progress_bar.dart';

class BookCard extends StatelessWidget {
  final BookDto book;

  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
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
                  child: BlocBuilder<BookThumbnailCubit, BookThumbnailState>(
                    bloc: BookThumbnailCubit()..getThumbnail(book.id),
                    builder: (context, state) {
                      if (state is BookThumbnailInitial ||
                          state is BookThumbnailLoading) {
                        return Image.asset(
                          "assets/images/cover.png",
                          fit: BoxFit.contain,
                          // height: 120,
                        );
                      } else if (state is BookThumbnailReady) {
                        return Image.memory(
                          Uint8List.fromList(state.thumbnail),
                          // height: 120,
                          fit: BoxFit.contain,
                        );
                      } else {
                        return Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      }
                    },
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
                    '${book.metadata.title}',
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
