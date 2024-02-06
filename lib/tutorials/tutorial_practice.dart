import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tutorial_post_practice.dart';

class PracticeTutorialPage extends StatefulWidget {
  const PracticeTutorialPage({Key? key}) : super(key: key);

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
  int randomRotation = 0;
  double rotationAngle = 0.0;
  bool allowRotation = true;

  Random random = Random();

  double imageHeight = 250;
  double imageWidth = 250;

  double containerHeight = 300;
  double containerWidth = 300;
  int count = 0;
  double position = 0.0;
  String leftIndication = 'Desliza la pantalla en direccion correspondiente';

  void change() {
    if (count >= 1 && count <= 3) {
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InstructionPostPracticePage(),
            ),
          );
      imageHeight -= 50;
      imageWidth -= 50;
      if (containerHeight <= 250) {
        containerHeight -= 50;
        containerWidth -= 50;
      } else {
        containerHeight -= 80;
        containerWidth -= 80;
      }
    } else {
      if (count >= 4 && count <= 5) {
        imageHeight -= 25;
        imageWidth -= 25;
        if (containerHeight <= 100) {
          containerHeight -= 25;
          containerWidth -= 25;
        } else {
          containerHeight -= 50;
          containerWidth -= 50;
        }
      } else {
        if (count == 8) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InstructionPostPracticePage(),
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 130),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Desliza la pantalla en la direccion indicada',
                                    style: TextStyle(
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

                  if (dx > 0 || dy > 0 || (dx < 0 || dy < 0)) {
                    double rotationActual = rotationAngle;
                    setState(() {
                      rotationAngle = rotation[randomRotation];
                      allowRotation = false;
                    });
                    if (dy > 0 && dy > dx) {
                      position = pi / 2;
                      if (rotationActual == position) {
                        setState(() {
                          change();
                          count++;
                        });
                        setState(() {
                          allowRotation = false;
                        });
                      }
                    } else {
                      if (dx > 0 && dx > dy) {
                        position = 0.0;
                        if (rotationActual == position) {
                          setState(() {
                            change();
                            count++;
                          });
                          setState(() {
                            allowRotation = false;
                          });
                        }
                      } else {
                        if (dx < 0 && dx < dy) {
                          position = pi;
                          if (rotationActual == position) {
                            setState(() {
                              change();
                              count++;
                            });
                            setState(() {
                              allowRotation = false;
                            });
                          }
                        } else {
                          if (dy < 0 && dy < dx) {
                            position = -pi / 2;
                            if (rotationActual == position) {
                              setState(() {
                                change();
                                count++;
                              });
                              setState(() {
                                allowRotation = false;
                              });
                            }
                          } else {
                            setState(() {
                              rotationAngle = rotation[randomRotation];
                              allowRotation = false;
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
            const Positioned(
              top: 130,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 70, right: 80),
                child: Text(
                  'Right',
                  style: TextStyle(
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
