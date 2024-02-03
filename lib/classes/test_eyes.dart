import 'package:flutter/material.dart';

class TestEyesightPage extends StatelessWidget {
  const TestEyesightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prueba de visión")),
      body: const Center(child: Text("Pagina para test de la vista")),
    );
  }
}