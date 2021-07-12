import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';

class SearchResults {
  final List<SeriesDto> seriesResults;
  final List<BookDto> bookResults;

  SearchResults({
    required this.seriesResults,
    required this.bookResults,
  });
}
