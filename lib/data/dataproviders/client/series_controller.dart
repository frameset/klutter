import 'package:dio/dio.dart' hide Headers;
import 'package:klutter/data/models/collectiondto.dart';
import 'package:klutter/data/models/pagebookdto.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:klutter/data/models/status.dart';

part 'series_controller.g.dart';

@RestApi()
abstract class SeriesController {
  factory SeriesController(Dio dio, {String baseUrl}) = _SeriesController;

  @GET("/api/v1/series")
  Future<PageSeriesDto> getSeries(
      {@Query("search") String? search,
      @Query("library_id") List<String>? libraryId,
      @Query("collection_id") List<String>? collectionId,
      @Query("status") List<Status>? status,
      @Query("read_status") List<String>? readStatus,
      @Query("publisher") List<String>? publisher,
      @Query("language") List<String>? language,
      @Query("genre") List<String>? genre,
      @Query("tag") List<String>? tag,
      @Query("age_rating") List<String>? ageRating,
      @Query("release_year") List<String>? releaseYear,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sort") List<String>? sort,
      @Query("author") List<String>? author});

  @GET("/api/v1/series/{seriesId}")
  Future<SeriesDto> getSeriesById(@Path("seriesId") String seriesId);

  @POST("/api/v1/series/{seriesId}/analyze")
  Future<void> analyzeSeries(@Path("seriesId") String seriesId);

  @GET("/api/v1/series/{seriesId}/books")
  Future<PageBookDto> getBooksFromSeries(@Path("seriesId") String seriesId,
      {@Query("media_status") List<String>? mediaStatus,
      @Query("read_status") List<String>? readStatus,
      @Query("tag") List<String>? tag,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sort") List<String>? sort,
      @Query("author") List<String>? author});

  @GET("/api/v1/series/{seriesId}/collections")
  Future<List<CollectionDto>> getCollectionsContainingSeries(
      @Path("seriesId") String seriesId);

  //PATCH /api/v1/series/{seriesId}/metadata update series metadata

  @POST("/api/v1/series/{seriesId}/metadata/refresh")
  Future<void> refreshMetadata(@Path("seriesId") String seriesId);

  @POST("/api/v1/series/{seriesId}/read-progress")
  Future<void> markAsRead(@Path("seriesId") String seriesId);

  @DELETE("/api/v1/series/{seriesId}/read-progress")
  Future<void> deleteReadProgress(@Path("seriesId") String seriesId);

  @Headers(<String, String>{"accept": "image/jpeg"})
  @GET("/api/v1/series/{seriesId}/thumbnail")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getThumbnail(@Path("seriesId") String seriesId);

  @GET("/api/v1/series/latest")
  Future<PageSeriesDto> getLatest(
      {@Query("library_id") List<String>? libraryId,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size});

  @GET("/api/v1/series/new")
  Future<PageSeriesDto> getNew(
      {@Query("library_id") List<String>? libraryId,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size});

  @GET("/api/v1/series/updated")
  Future<PageSeriesDto> getUpdated(
      {@Query("library_id") List<String>? libraryId,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size});
}
