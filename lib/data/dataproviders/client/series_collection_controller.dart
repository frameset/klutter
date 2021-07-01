import 'package:dio/dio.dart' hide Headers;
import 'package:klutter/data/models/collectioncreationdto.dart';
import 'package:klutter/data/models/collectiondto.dart';
import 'package:klutter/data/models/collectionupdatedto.dart';
import 'package:klutter/data/models/pagecollectiondto.dart';
import 'package:klutter/data/models/pageseriesdto.dart';
import 'package:retrofit/retrofit.dart';

part 'series_collection_controller.g.dart';

@RestApi()
abstract class SeriesCollectionController {
  factory SeriesCollectionController(Dio dio, {String baseUrl}) =
      _SeriesCollectionController;

  @GET("/api/v1/collections")
  Future<PageCollectionDto> getCollections(
      {@Query("search") String? search,
      @Query("library_id") List<String>? libraryId,
      @Query("unpaged") bool? unpaged,
      @Query("page") int? page,
      @Query("size") int? size});

  @POST("/api/v1/collections")
  Future<CollectionDto> newCollection(
      @Body() CollectionCreationDto collectionCreationDto);

  @GET("/api/v1/collections/{id}")
  Future<CollectionDto> getCollection(@Path("id") String collectionId);

  @DELETE("/api/v1/collections/{id}")
  Future<CollectionDto> deleteCollection(@Path("id") String collectionId);

  @PATCH("/api/v1/collections/{id}")
  Future<CollectionDto> updateCollection(@Path("id") String collectionId,
      @Body() CollectionUpdateDto collectionUpdateDto);

  @GET("/api/v1/collections/{id}/series")
  Future<PageSeriesDto> getSeries(@Path("id") String collectionId,
      {@Query("library_id") List<String>? libraryId,
      @Query("status") List<String>? status,
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
      @Query("sort") List<String>? sort});

  @Headers(<String, String>{"accept": "image/jpeg"})
  @GET("/api/v1/collections/{id}/thumbnail")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getThumbnail(@Path("id") String collectionId);
}
