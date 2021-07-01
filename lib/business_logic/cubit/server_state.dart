part of 'server_cubit.dart';

abstract class ServerState extends Equatable {
  const ServerState();

  @override
  List<Object> get props => [];
}

class ServerInitial extends ServerState {}

class ServersFetched extends ServerState {
  final List<Server> servers;

  ServersFetched({required this.servers});

  @override
  List<Object> get props => [servers];
}

class ServersEmpty extends ServerState {}

class ServersFailed extends ServerState {}

class ServerReady extends ServerState {}

class ServerAddNewFailed extends ServerState {}
