import 'package:dio/dio.dart' hide Headers;
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/data/models/libraryupdatedto.dart';
import 'package:retrofit/retrofit.dart';

part 'library_controller.g.dart';

@RestApi()
abstract class LibraryController {
  factory LibraryController(Dio dio, {String baseUrl}) = _LibraryController;

  @GET("/api/v1/libraries")
  Future<List<LibraryDto>> getLibraries();

  @GET("api/v1/libraries/{libraryid}")
  Future<LibraryDto> getLibraryById(@Path("libraryid") String libraryId);

  @PUT("/api/v1/libraries/{libraryId}")
  Future<void> updateLibrary(@Path("libraryId") String libraryId,
      @Body() LibraryUpdateDto libraryUpdateDto);

  @POST("/api/v1/libraries/{libraryId}/analyze")
  Future<void> analyzeLibrary(@Path("libraryId") String libraryId);

  @DELETE("/api/v1/libraries/{libraryId}")
  Future<void> deleteLibrary(@Path("libraryId") String libraryId);

  @POST("/api/v1/libraries/{libraryId}/metadata/refresh")
  Future<void> refreshLibraryMetadata(@Path("libraryId") String libraryId);

  @POST("/api/v1/libraries/{libraryId}/scan")
  Future<void> scanLibrary(@Path("libraryId") String libraryId);
}
