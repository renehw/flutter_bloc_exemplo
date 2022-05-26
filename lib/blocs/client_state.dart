import 'package:flutter_bloc_ex/index.dart';

abstract class ClientState {
  List<Client> clients;

  ClientState({
    required this.clients,
  });
}

class ClientInitialState extends ClientState {
  ClientInitialState() : super(clients: []);
}

class ClientSucessState extends ClientState {
  ClientSucessState({required List<Client> clients}) : super(clients: clients);
}
