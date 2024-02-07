import 'package:flutter/material.dart';
import '../main.dart';

class FinalTutorialsPage extends StatefulWidget {
  const FinalTutorialsPage({super.key});
  @override
  FinalTutorialsPageState createState() => FinalTutorialsPageState();
}

class FinalTutorialsPageState extends State<FinalTutorialsPage> {
  List<String> images = [
    "final1.jpeg",
    "final2.jpeg",
    "finalT3.jpg",
  ];

  List<String> instructions = [
    "Evitar la luz brillante",
    "No te inclines",
    "Final",
  ];

  List<String> instructionsDown = [
    "Asegúrate de no reflejar ninguna luz con tu dispositivo",
    "Sostenga el teléfono recto",
    "Has completado los tutoriales",
  ];
  int currentInstructionIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Instrucciones"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/${images[currentInstructionIndex]}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                instructions[currentInstructionIndex],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                instructionsDown[currentInstructionIndex],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentInstructionIndex > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentInstructionIndex--;
                        });
                      },
                      child: const Text("Atras"),
                    ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: currentInstructionIndex < instructions.length - 1
                        ? () {
                            setState(() {
                              currentInstructionIndex++;
                            });
                          }
                        : () async {
                            Navigator.popUntil(context, ModalRoute.withName('/'));
                          },
                    child: Text(
                      currentInstructionIndex < instructions.length - 1
                          ? "Siguiente"
                          : "Terminar",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
