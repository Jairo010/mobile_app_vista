import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tutorial_post_practice.dart';

class PracticeTutorialPage extends StatefulWidget {
  const PracticeTutorialPage({super.key});

  @override
  PracticeTutorialPageState createState() => PracticeTutorialPageState();
}

class PracticeTutorialPageState extends State<PracticeTutorialPage> {
  List<double> rotation = [
    pi / 2,
    -pi / 2,
    pi,
    0,
  ];
  List<String> directions = [
    'Arriba',
    'Abajo',
    'Izquierda',
    'Derecha',
  ];
  int randomRotation = 0;
  int randomDirectios = 0;
  double rotationAngle = 0.0;
  bool allowRotation = true;

  Random random = Random();

  double imageHeight = 250;
  double imageWidth = 250;

  double containerHeight = 300;
  double containerWidth = 300;
  int count = 0;
  double position = 0.0;
  String currectDirection = '';
  String estDirection = '';
  String leftIndication = 'Desliza la pantalla en direccion indicada';

  void change() {
    if (count >= 0 && count < 3) {
      imageHeight -= 50;
      imageWidth -= 50;
      if (containerHeight <= 250) {
        containerHeight -= 50;
        containerWidth -= 50;
      } else {
        containerHeight -= 70;
        containerWidth -= 70;
      }
    } else {
      if (count >= 4 && count <= 5) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InstructionPostPracticePage(),
          ),
        );
      } else {
        if (count == 8) {}
      }
    }
  }

  @override
  void initState() {
    super.initState();
    currectDirection = directions[0];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        maxWidth: 180,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 130),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    leftIndication,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onPanDown: (_) {
                  setState(() {
                    allowRotation = true;
                  });
                },
                onPanUpdate: (details) {
                  if (!allowRotation) return;
                  final dx = details.delta.dx;
                  final dy = details.delta.dy;
                  randomRotation = random.nextInt(4);
                  randomDirectios = random.nextInt(4);

                  if (dx > 0 || dy > 0 || (dx < 0 || dy < 0)) {
                    String directionActual = currectDirection;
                    setState(() {
                      rotationAngle = rotation[randomRotation];
                      allowRotation = false;
                      currectDirection = directions[randomDirectios];
                    });
                    if (dy > 0 && dy > dx) {
                      position = pi / 2;
                      estDirection = 'Abajo';
                      if (directionActual == estDirection) {
                        setState(() {
                          change();
                          count++;
                          leftIndication = 'Bien. Sigue asi';
                        });
                        setState(() {
                          allowRotation = false;
                        });
                      } else {
                        setState(() {
                          leftIndication =
                              'ERROR: Solo tienes que deslizar en direccion indicada por el paciente';
                        });
                      }
                    } else {
                      if (dx > 0 && dx > dy) {
                        position = 0.0;
                        estDirection = 'Derecha';
                        if (directionActual == estDirection) {
                          setState(() {
                            change();
                            count++;
                            leftIndication = 'Bien. Sigue asi';
                          });
                          setState(() {
                            allowRotation = false;
                          });
                        } else {
                          setState(() {
                            leftIndication =
                                'ERROR: Solo tienes que deslizar en direccion indicada por el paciente';
                          });
                        }
                      } else {
                        if (dx < 0 && dx < dy) {
                          position = pi;
                          estDirection = 'Izquierda';
                          if (directionActual == estDirection) {
                            setState(() {
                              change();
                              count++;
                              leftIndication = 'Bien. Sigue asi';
                            });
                            setState(() {
                              allowRotation = false;
                            });
                          } else {
                            setState(() {
                              leftIndication =
                                  'ERROR: Solo tienes que deslizar en direccion indicada por el paciente';
                            });
                          }
                        } else {
                          if (dy < 0 && dy < dx) {
                            position = -pi / 2;
                            estDirection = 'Arriba';
                            if (directionActual == estDirection) {
                              setState(() {
                                change();
                                count++;
                                leftIndication = 'Bien. Sigue asi';
                              });
                              setState(() {
                                allowRotation = false;
                              });
                            } else {
                              
                            }
                          } else {
                            setState(() {
                              rotationAngle = rotation[randomRotation];
                              allowRotation = false;
                              currectDirection = directions[randomDirectios];
                              
                            });
                          }
                        }
                      }
                    }
                  }
                },
                onPanEnd: (_) {
                  setState(() {
                    allowRotation = false;
                  });
                },
                child: Container(
                  color: Colors.black,
                  width: containerWidth,
                  height: containerHeight,
                  child: Center(
                    child: Transform.rotate(
                      angle: rotationAngle,
                      child: Image.asset(
                        'assets/images/letter.jpg',
                        height: imageHeight,
                        width: imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, right: 80),
                child: Text(
                  currectDirection,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
