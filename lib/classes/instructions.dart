import 'package:flutter/material.dart';
import 'test_eyes.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({Key? key}) : super(key: key);
  @override
  InstructionsPageState createState() => InstructionsPageState();
}

class InstructionsPageState extends State<InstructionsPage> {
  List<String> nameOfInstruction = [
    "Sentarse",
    "Nivel del ojo",
    "Distancia",
    "Cubrir un ojo",
  ];
  List<String> instructions = [
    "Pidele al paciente tomar asiento",
    "Estar seguro de que estas sosteniendo el dispositivo al nivel de los ojos del paciente",
    "Toma una distancia de 2 metros entre tu y los ojos del paciente",
    "Pidele al paciente que se cubra un ojo con la palma de su mano",
  ];
  int currentInstructionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instructions"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,         
          children: [
            Text(
              nameOfInstruction[currentInstructionIndex],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              instructions[currentInstructionIndex],
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
                    child: const Text("Back"),
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
                              builder: (context) => const TestEyesightPage(),
                            ),
                          );
                        },
                  child: Text(
                    currentInstructionIndex < instructions.length - 1
                        ? "Next"
                        : "Done",
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
