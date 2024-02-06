import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'results.dart';
import 'settings.dart';

class TestEyesightPage extends StatefulWidget {
  const TestEyesightPage({super.key});

  @override
  TestEyesightPageState createState() => TestEyesightPageState();
}

class TestEyesightPageState extends State<TestEyesightPage> {
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

  double imageHeight = 300;
  double imageWidth = 300;

  double containerHeight = 410;
  double containerWidth = 410;
  int count = 0;
  double position = 0.0;
  double logMarc = 29.1;
  double size = 1.0;
  String result = '29.1';
  String sizeResult = '1.0';
  int countMistakes = 0;

  void change() {
    if (count >= 0 && count <= 3) {
      size -= 0.2;
      sizeResult = size.toStringAsFixed(2);
      size = double.parse(sizeResult);
      logMarc /= 1.58;
      result = logMarc.toStringAsFixed(3);
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
        size -= 0.1;
        sizeResult = size.toStringAsFixed(2);
        size = double.parse(sizeResult);
        logMarc /= 1.58;
        result = logMarc.toStringAsFixed(3);
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
              builder: (context) => ResultWidget(size: size),
            ),
          );
        }
      }
    }
  }
  void changeMistake(){
    if (countMistakes < 0) {
      countMistakes = 0;
    }
    if(countMistakes >= 0){
      countMistakes--;
    }
  }


  void routeOnMistake(){
    if(countMistakes == 3){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultWidget(size: size),
            ),
          );
    }
  }
  @override
  void initState() {
    cargarDistancia();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  String selectedDistance = '';
  SettingsPageState settingsDistance = SettingsPageState();

  void cargarDistancia() {
    settingsDistance.loadDistanceSetting().then((value) {
      setState(() {
        selectedDistance = value;
      });
    });
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
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marca $size',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tamanio (mm) $result',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Distancia $selectedDistance',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                          allowRotation = false;
                          change();
                          changeMistake();
                          count++;
                        });
                      } else {
                        setState(() {
                          routeOnMistake();
                          countMistakes++;
                        });
                      }
                    } else {
                      if (dx > 0 && dx > dy) {
                        position = 0.0;
                        if (rotationActual == position) {
                          setState(() {
                            allowRotation = false;
                            change();
                            changeMistake();
                            count++;
                          });
                        } else {
                          setState(() {
                            routeOnMistake();
                            countMistakes++;
                          });
                        }
                      } else {
                        if (dx < 0 && dx < dy) {
                          position = pi;
                          if (rotationActual == position) {
                            setState(() {
                              allowRotation = false;
                              change();
                              changeMistake();
                              count++;
                            });
                          } else {
                            setState(() {
                              routeOnMistake();
                              countMistakes++;
                            });
                          }
                        } else {
                          if (dy < 0 && dy < dx) {
                            position = -pi / 2;
                            if (rotationActual == position) {
                              setState(() {
                                allowRotation = false;
                                change();
                                changeMistake();
                                count++;
                              });
                            } else {
                              setState(() {
                                routeOnMistake();
                                countMistakes++;
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
