import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'final_tutorials.dart';

class InstructionPostPacientPage extends StatefulWidget {
  const InstructionPostPacientPage({super.key});
  @override
  InstructionPostPacientPageState createState() =>
      InstructionPostPacientPageState();
}

class InstructionPostPacientPageState
    extends State<InstructionPostPacientPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  List<String> images = [
    "finalT2.jpg",
  ];

  List<String> instructions = [
    "Siguiente paso",
  ];

  List<String> instructionsDown = [
    "Aprender como obtener lo mejor de la prueba",
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
              // Navegar a la página principal
              Navigator.pushReplacementNamed(context, '/');
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
                                builder: (context) =>
                                    const FinalTutorialsPage(),
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
      ),
    );
  }
}
