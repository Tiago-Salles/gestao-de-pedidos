import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_pedidos/app/models/cliente_model.dart';
import 'package:gestao_de_pedidos/app/repositories/client_repository.dart';
import 'package:rxdart/rxdart.dart';

class ClientBloc{
  final behaviorGetRequests = BehaviorSubject<List<ClientModel>>();
  ClientRepository clientRepository = ClientRepository();
  List<ClientModel> datasFromDB = [];

  void getDataFromDB(String clientName) async {
    final datasFromDB =
        await clientRepository.getDataFromDB(clientName);
    behaviorGetRequests.sink.add(datasFromDB);
  }
}