import 'package:flutter/material.dart';
import 'package:gestao_de_pedidos/app/pages/home/home_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}