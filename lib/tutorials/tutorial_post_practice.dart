import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tuto_instructions_paciente.dart';

class InstructionPostPracticePage extends StatefulWidget {
  const InstructionPostPracticePage({super.key});
  @override
  InstructionPostPracticePageState createState() => InstructionPostPracticePageState();
}

class InstructionPostPracticePageState extends State<InstructionPostPracticePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  List<String> images = [
    "resulPractice.jpeg",
    "finalT1.jpg",
  ];

  List<String> instructions = [
    "Siga hasta que termine la prueba",
    "Siguiente paso",
  ];

  List<String> instructionsDown = [
    "Calculamos el resultado para usted ",
    "Explicar al paciente que hacer",
  ];
  int currentInstructionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instrucciones"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${images[currentInstructionIndex]}',
              height: 320,
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
                              builder: (context) => const InstructionsPacientePage(),
                            ),
                          );
                        },
                  child: const Text(
                         "Siguiente",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
