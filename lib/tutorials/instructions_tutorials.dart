import 'package:flutter/material.dart';
import 'tutorial_practice.dart';
import '../main.dart';

class InstructionTutorialsPage extends StatefulWidget {
  const InstructionTutorialsPage({super.key});
  @override
  InstructionTutorialsPageState createState() => InstructionTutorialsPageState();
}

class InstructionTutorialsPageState extends State<InstructionTutorialsPage> {
  List<String> images = [
    "rotationIma.jpg",
    "ask1.jpeg",
    "ask2.jpeg",
  ];

  List<String> instructions = [
    "Esta prueba utiliza una forma E",
    "Preguntar al paceinte que muestre en que direccion piensa que esta la E",
    "Desliza la pantalla en la direccion que el paciente dice",
  ];

  List<String> instructionsDown = [
    "Apunta en distintas direcciones y cambia de tamaño para medir la vista ",
    "",
    "No necesitas comprobar si esta en lo correcto",
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
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PracticeTutorialPage(),
                            ),
                          );
                        },
                  child: Text(
                    currentInstructionIndex < instructions.length - 1
                        ? "Siguiente"
                        : "Practicar",
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
