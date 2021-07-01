import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klutter/data/models/server.dart';
import 'package:klutter/data/repositories/server_check_repository.dart';

part 'servercheck_state.dart';

class ServerCheckCubit extends Cubit<ServerCheckState> {
  ServerCheckRepository _repository = ServerCheckRepository();
  ServerCheckCubit() : super(ServerCheckInitial());

  Future<void> checkServer(Server server) async {
    bool online = await _repository.isServerOnline(server);
    online ? emit(ServerCheckOnline()) : emit(ServerCheckOffline());
  }
}
