import 'package:dio/dio.dart' hide Headers;
import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/bookmetadataupdatedto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/pagedto.dart';
import 'package:klutter/data/models/readlistdto.dart';
import 'package:klutter/data/models/readprogressupdatedto.dart';
import 'package:retrofit/retrofit.dart';

part 'book_controller.g.dart';

@RestApi()
abstract class BookController {
  factory BookController(Dio dio, {String baseUrl}) = _BookController;

  @GET("/api/v1/books")
  Future<PageBookDto> getBooks(
      {@Query("search") String? search,
      @Query("library_id") List<String>? libraryId,
      @Query("media_status") List<String>? mediaStatus,
      @Query("read_status") List<String>? readStatus,
      @Query("tag") List<String>? tag,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sort") List<String>? sort});

  @GET("/api/v1/books/{bookId}")
  Future<BookDto> getBook(@Path("bookId") String bookId);

  @POST("/api/v1/books/{bookId}/analyze")
  Future<HttpResponse<void>> analyzeBook(@Path("bookId") String bookId);

  //Some methods missing around downloading the book file

  @PATCH("/api/v1/books/{bookId}/metadata")
  Future<HttpResponse<void>> updateMetadata(@Path("bookId") String bookId,
      @Body() BookMetadataUpdateDto bookMetadataUpdateDto);

  @POST("/api/v1/books/{bookId}/metadata/refresh")
  Future<HttpResponse<void>> refreshMetadata(@Path("bookId") String bookId);

  @GET("/api/v1/books/{bookId}/next")
  Future<BookDto> getNextBook(@Path("bookId") String bookId);

  @GET("/api/v1/books/{bookId}/pages")
  Future<List<PageDto>> getPages(@Path("bookId") String bookId);

  @Headers(<String, String>{"accept": "*/*"})
  @GET("/api/v1/books/{bookId}/pages/{pageNumber}")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getPage(
      @Path("bookId") String bookId, @Path("pageNumber") int pageNumber,
      {@Query("convert") String? convert,
      @Query("zero_based") bool? zeroBased});

  @Headers(<String, String>{"accept": "image/jpeg"})
  @GET("/api/v1/books/{bookId}/pages/{pageNumber}/thumbnail")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getPageThumbnail(
      @Path("bookId") String bookId, @Path("pageNumber") int pageNumber);

  @GET("/api/v1/books/{bookId}/previous")
  Future<BookDto> getPreviousBook(@Path("bookId") String bookId);

  @PATCH("/api/v1/books/{bookId}/read-progress")
  Future<void> markAsRead(@Path("bookId") String bookId,
      @Body() ReadProgressUpdateDto readProgressUpdateDto);

  @DELETE("/api/v1/books/{bookId}/read-progress")
  Future<void> deleteReadProgress(@Path("bookId") String bookId);

  @GET("/api/v1/books/{bookId}/readlists")
  Future<List<ReadListDto>> getReadLists(@Path("bookID") String bookId);

  @Headers(<String, String>{"accept": "image/jpeg"})
  @GET("/api/v1/books/{bookId}/thumbnail")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getThumbnail(@Path("bookId") String bookId);

  //Return newly added or updated books.
  @GET("/api/v1/books/latest")
  Future<PageBookDto> getLatest(
      {@Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size});

  //Return first unread book of series with at least one book read and no books in progress.
  @GET("/api/v1/books/ondeck")
  Future<PageBookDto> getOnDeck(
      {@Query("page") int? page, @Query("size") int? size});
}
