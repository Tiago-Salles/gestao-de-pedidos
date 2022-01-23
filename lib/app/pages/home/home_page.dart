import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_pedidos/app/pages/home/client_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientBloc clientBloc = ClientBloc();
    final behaviorRequests = BehaviorSubject<List<int>>();
    List<int> requestsList = [];
    String clientName = "";
    String request = "";
    String date = "";

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<int>>(
                  initialData: const [],
                  stream: behaviorRequests.stream,
                  builder: (context, snapshot) {
                    return snapshot.data!.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                clientName = value;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    await clientBloc.getDataFromDB(clientName);
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container();
                  }),
              StreamBuilder<List<int>>(
                initialData: const [],
                stream: behaviorRequests.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              clientName = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Nome do cliente",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              date = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Data",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              request = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Pedido",
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  requestsList.clear();
                                  behaviorRequests.sink.add(requestsList);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text(
                                        "Deseja salvar este pedido?",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 25,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Nao",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection(clientName)
                                                .doc(date)
                                                .set({
                                              "clientName": clientName,
                                              "request": request,
                                            }).then(
                                              (value) =>
                                                  const ScaffoldMessenger(
                                                child: SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Pedido salvo com sucesso",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                            requestsList.clear();
                                            behaviorRequests.sink
                                                .add(requestsList);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Sim",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.share,
                                  size: 50,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      child: const Center(
                        child: Text(
                          "Pesquise um cliente ou adicione um pedido",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<List<int>>(
        initialData: const [],
        stream: behaviorRequests.stream,
        builder: (context, snapshot) {
          return snapshot.data!.isEmpty
              ? FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    requestsList.add((requestsList.length) + 1);
                    behaviorRequests.sink.add(requestsList);
                  },
                  child: const Icon(Icons.add),
                )
              : Container();
        },
      ),
    );
  }
}
