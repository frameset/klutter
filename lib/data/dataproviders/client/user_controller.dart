import 'package:dio/dio.dart';
import 'package:klutter/data/models/rolesupdatedto.dart';
import 'package:klutter/data/models/userdto.dart';
import 'package:klutter/data/models/userswithsharedlibrariesdto.dart';
import 'package:retrofit/retrofit.dart';

part 'user_controller.g.dart';

@RestApi()
abstract class UserController {
  factory UserController(Dio dio, {String baseUrl}) = _UserController;

  @GET("/api/v1/users")
  Future<List<UsersWithSharedLibrariesDto>> getUsers();

  // @POST("/api/v1/users")
  // Future<UserDto> newUser(String email, String password, List<String> roles);

  @DELETE("/api/v1/users/{id}")
  Future<void> deleteUser(@Path("id") String userId);

  @PATCH("/api/v1/users/{id}")
  Future<void> updateUserRoles(
      @Path("id") String userId, @Body() RolesUpdateDto rolesUpdateDto);

  //PATCH /api/v1/users/{id}/shared-libraries method for setting shared library, probably not needed

  @GET("/api/v1/users/me")
  Future<UserDto> getMe();

  //PATCH /api/v1/users/me/password method for updating password, not sure if wanted
}
