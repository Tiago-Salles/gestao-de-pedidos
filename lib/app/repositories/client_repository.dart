import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_pedidos/app/models/cliente_model.dart';

class ClientRepository {
  List<ClientModel> datasFromDB = [];

  Future<List<ClientModel>> getDataFromDB(String clientName) async {
    final getData =
        await FirebaseFirestore.instance.collection(clientName).get();
    for (var doc in getData.docs) {
      datasFromDB.add(ClientModel.fromJson(doc.data()));
    }
    return datasFromDB;
  }
}
