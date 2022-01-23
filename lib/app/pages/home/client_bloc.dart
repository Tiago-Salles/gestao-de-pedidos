import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_pedidos/app/models/cliente_model.dart';
import 'package:gestao_de_pedidos/app/repositories/client_repository.dart';

class ClientBloc{
  ClientRepository clientRepository = ClientRepository();
  List<ClientModel> datasFromDB = [];

  Future<List<ClientModel>> getDataFromDB(String clientName) async {
    final datasFromDB =
        await clientRepository.getDataFromDB(clientName);
    return datasFromDB;
  }
}