import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_ex/blocs/client_events.dart';
import 'package:flutter_bloc_ex/blocs/client_state.dart';
import 'package:flutter_bloc_ex/index.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _clientRepo = ClientsRepository();

  ClientBloc() : super(ClientInitialState()) {
    on<LoadClientEvent>(
      (event, emit) => emit(ClientSucessState(clients: _clientRepo.loadClients())),
    );

    on<AddClientEvent>(
      (event, emit) => emit(ClientSucessState(clients: _clientRepo.addClient(event.client))),
    );

    on<RemoveClientEvent>(
      (event, emit) => emit(ClientSucessState(clients: _clientRepo.removeClient(event.client))),
    );
  }
}


/* ->Opção usada quando não é usado o package bloc.


class ClientBloc {
  final _clientRepo = ClientsRepository();

  final StreamController<ClientEvent> _inputClientController = StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientController = StreamController<ClientState>();

  Sink<ClientEvent> get inputClient => _inputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvent event) {
    List<Client> clients = [];

    if (event is LoadClientEvent) {
      clients = _clientRepo.loadClients();
    } else if (event is AddClientEvent) {
      clients = _clientRepo.addClient(event.client);
    } else if (event is RemoveClientEvent) {
      clients = _clientRepo.removeClient(event.client);
    }

    _outputClientController.add(ClientSucessState(clients: clients));
  }
} */
