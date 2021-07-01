import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/server.dart';
import 'package:klutter/data/repositories/server_repository.dart';
import 'package:uuid/uuid.dart';

part 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  final ServerRepository _repository = ServerRepository();
  ServerCubit() : super(ServerInitial());

  Future<void> getServers() async {
    try {
      final List<Server> servers = await _repository.getAllServers();
      if (servers.isEmpty) {
        emit(ServersEmpty());
      } else {
        emit(ServersFetched(servers: servers));
      }
    } on Exception catch (_) {
      emit(ServersFailed());
    }
  }

  Future<void> addNewServer(
      {required String serverName,
      required String url,
      required String username,
      required String password}) async {
    print("adding new server");
    emit(ServerInitial());
    final String key = Uuid().v1();
    Server newServer = Server(
        name: serverName,
        url: url,
        username: username,
        password: password,
        key: key);
    bool works = await _repository.testServer(newServer);
    if (works) {
      await _repository.addServer(newServer);
      getServers();
    } else {
      emit(ServerAddNewFailed());
      getServers();
    }
  }

  Future<void> removeServer(String serverKey) async {
    emit(ServerInitial());
    await _repository.removeServer(serverKey);
    getServers();
  }

  Future<void> setCurrentServer(Server server) async {
    emit(ServerInitial());
    await _repository.setCurrentServer(server);
    emit(ServerReady());
  }
}
