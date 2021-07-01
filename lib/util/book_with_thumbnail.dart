import 'package:klutter/data/models/bookdto.dart';

class BookWithThumbnail {
  List<int> thumb;
  BookDto bookDto;

  BookWithThumbnail({
    required this.thumb,
    required this.bookDto,
  });
}
