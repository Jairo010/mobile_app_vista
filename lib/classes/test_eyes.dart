import 'package:flutter/material.dart';

class TestEyesightPage extends StatelessWidget {
  const TestEyesightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              // Textos
              Text(
                'LogMar 1.0',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Size (mm) 29.1',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Distance 2m',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              color: Colors.black,
              width: 300, // Ancho del contenedor
              height: 200, // Alto del contenedor
              child: Center(
                child: Image.asset(
                  'assets/images/letter.jpg',
                  height: 150, // Altura de la imagen dentro del contenedor
                  width: 150, // Ancho de la imagen dentro del contenedor
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Columna con el contenido
        ],
      ),
    );
  }
}
