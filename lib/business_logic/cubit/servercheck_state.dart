part of 'servercheck_cubit.dart';

abstract class ServerCheckState extends Equatable {
  const ServerCheckState();

  @override
  List<Object> get props => [];
}

class ServerCheckInitial extends ServerCheckState {}

class ServerCheckOnline extends ServerCheckState {}

class ServerCheckOffline extends ServerCheckState {}
