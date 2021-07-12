import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:klutter/data/dataproviders/client/api_client.dart';
import 'package:klutter/data/dataproviders/client/user_controller.dart';
import 'package:klutter/data/models/server.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class ServerRepository {
  IOSOptions iosOptions =
      IOSOptions(accessibility: IOSAccessibility.first_unlock);
  final storage = FlutterSecureStorage();
  Uuid uuid = Uuid();

  Future<List<Server>> getAllServers() async {
    Map<String, String> allPairs = await storage.readAll();
    if (allPairs.isEmpty) {
      return List.empty();
    } else {
      if (allPairs.containsKey('Current Server')) {
        allPairs.remove('Current Server');
      }
      List<Map<String, dynamic>> serverJsons = allPairs.values
          .toList()
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
      return serverJsons.map((e) => Server.fromJson(e)).toList();
    }
  }

  Future<void> addServer(Server server) async {
    String serverString = jsonEncode(server.toJson());
    return await storage.write(
      key: server.key,
      value: serverString,
      iOptions: iosOptions,
    );
  }

  Future<void> removeServer(String key) async {
    return await storage.delete(key: key);
  }

  Future<void> setCurrentServer(Server server) async {
    String serverString = jsonEncode(server.toJson());
    await storage.delete(key: 'Current Server');
    await storage.write(key: 'Current Server', value: serverString);
    await ApiClient.init();
  }

  Future<bool> testServer(Server server) async {
    BaseOptions options = BaseOptions(baseUrl: server.url, headers: {
      'Authorization':
          genBasicAuthHeaderValue(server.username, server.password),
    });
    Dio _dio = Dio(options);
    try {
      await UserController(_dio).getMe();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}

String genBasicAuthHeaderValue(String user, String pass) {
  return 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
}
