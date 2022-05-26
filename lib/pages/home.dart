import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ex/blocs/client_bloc.dart';
import 'package:flutter_bloc_ex/blocs/client_events.dart';
import 'package:flutter_bloc_ex/blocs/client_state.dart';
import 'package:flutter_bloc_ex/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ['Maria Almeida', 'Vinicius Silva', 'Luiz Williams', 'Bianca Nevis'].elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            splashRadius: 18.0,
            onPressed: () {
              bloc.add(
                AddClientEvent(
                  client: Client(nome: randomName()),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: BlocBuilder<ClientBloc, ClientState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ClientInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ClientSucessState) {
                final clientsList = state.clients;

                return ListView.separated(
                  itemCount: clientsList.length,
                  separatorBuilder: (_, __) {
                    return const Divider();
                  },
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(clientsList[index].nome.hashCode * 0xFFFFFF).withOpacity(1.0),
                        child: ClipRRect(
                          child: Text(
                            clientsList[index].nome.substring(0, 1),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(clientsList[index].nome),
                      trailing: IconButton(
                        splashRadius: 18.0,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          bloc.add(
                            RemoveClientEvent(client: clientsList[index]),
                          );
                        },
                      ),
                    );
                  }),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
